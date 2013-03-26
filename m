From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] difftool: don't overwrite modified files
Date: Tue, 26 Mar 2013 10:53:48 +0100
Message-ID: <5151702C.9060502@viscovery.net>
References: <cover.1364045138.git.john@keeping.me.uk> <e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk> <7vd2up4bo7.fsf@alter.siamese.dyndns.org> <20130324123620.GA2286@serenity.lan> <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com> <20130324151557.GB2286@serenity.lan> <514FFFC7.3090004@viscovery.net> <20130325104219.GD2286@serenity.lan> <20130325214430.GG2286@serenity.lan> <51515E92.4030009@viscovery.net> <20130326093141.GI2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 26 10:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKQaC-0003SQ-Px
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 10:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434Ab3CZJxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 05:53:53 -0400
Received: from so.liwest.at ([212.33.55.24]:31904 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759645Ab3CZJxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 05:53:52 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UKQZg-0008Dn-O5; Tue, 26 Mar 2013 10:53:48 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 67A741660F;
	Tue, 26 Mar 2013 10:53:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130326093141.GI2286@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219150>

Am 3/26/2013 10:31, schrieb John Keeping:
> On Tue, Mar 26, 2013 at 09:38:42AM +0100, Johannes Sixt wrote:
>> One question though: Do I understand correctly that the temporary
>> directories are leaked in the case of an "edit conflict"? If so, is it
>> worth a warning for the user to clean up the garbage?
> 
> Do you mean for normal users or for those running the tests?  In normal
> usage we do print a warning - it's in the existing code, triggered by
> setting "$error = 1" - you can see that if you run the tests with "-v".

I meant for normal users. I see the error now. Thanks.

> The last test does result in /tmp filling up with temporary directories
> though, it would be good if the test could clean up after itself.  The
> best I can come up with is adding something like this immediately after
> running difftool but I'm not entirely happy with the ".." in the
> argument to rm:
> 
> 	test_when_finished rm -rf "$(cat tmpdir)/.."

Wrap the test in

	(
		TMPDIR=$TRASH_DIRECTORY &&
		export TMPDIR &&
	...
	)

It works for me.

-- Hannes
