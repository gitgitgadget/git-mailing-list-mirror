From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v8 4/4] git-rebase: add keep_empty flag
Date: Wed, 18 Jul 2012 09:10:06 +0200
Message-ID: <5006614E.8090601@viscovery.net>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com> <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com> <1334932577-31232-5-git-send-email-nhorman@tuxdriver.com> <CAOeW2eEchYzRYYUBySKg5xYY3vBDy8GVcAd=ay-HoAGDLZtORw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOOq-0005gU-GV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab2GRHKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:10:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43540 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751471Ab2GRHKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:10:14 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SrOOd-0006DW-ES; Wed, 18 Jul 2012 09:10:07 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DF9021660F;
	Wed, 18 Jul 2012 09:10:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAOeW2eEchYzRYYUBySKg5xYY3vBDy8GVcAd=ay-HoAGDLZtORw@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201654>

Am 7/18/2012 8:20, schrieb Martin von Zweigbergk:
> On Fri, Apr 20, 2012 at 7:36 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
>>  pick_one () {
>>         ff=--ff
>> +
>>         case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>>         case "$force_rebase" in '') ;; ?*) ff= ;; esac
>>         output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>> +
>> +       if is_empty_commit "$sha1"
>> +       then
>> +               empty_args="--allow-empty"
>> +       fi
>> +
>>         test -d "$rewritten" &&
>>                 pick_one_preserving_merges "$@" && return
>> -       output git cherry-pick $ff "$@"
>> +       output git cherry-pick $empty_args $ff "$@"
> 
> The is_empty_commit check seems to mean that if $sha1 is an "empty"
> commit, we pass the --allow-empty option to cherry-pick. If it's not
> empty, we don't. The word "allow" in "allow-empty" suggests that even
> if the commit is not empty, cherry-pick would not mind. So, can we
> always pass "allow-empty" to cherry-pick (i.e. even if the commit to
> pick is not empty)?

I don't think so. If the commit is not empty, but all its changes are
already in HEAD, then it will become "empty" when cherry-picked to HEAD.
In such a case, we usually do not want to record an empty commit, but stop
rebase to give to user a chance to deal with the situation.

-- Hannes
