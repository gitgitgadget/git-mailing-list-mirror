From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the
 command invocation
Date: Mon, 14 Jul 2008 12:03:27 -0700
Message-ID: <7vy744ffuo.fsf@gitster.siamese.dyndns.org>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1216018557.487af87d7bd28@webmail.eunet.at>
 <alpine.DEB.1.00.0807141319420.8950@racer>
 <200807142054.35027.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITLz-00077Q-Uf
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYGNTDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYGNTDk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:03:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbYGNTDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:03:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 648962B072;
	Mon, 14 Jul 2008 15:03:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 65D0E2B06E; Mon, 14 Jul 2008 15:03:31 -0400 (EDT)
In-Reply-To: <200807142054.35027.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Mon, 14 Jul 2008 20:54:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9107DC00-51D7-11DD-BD83-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88449>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Montag, 14. Juli 2008, Johannes Schindelin wrote:
>> Hi,
>>
>> On Mon, 14 Jul 2008, Johannes Sixt wrote:
>> > Zitat von Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> > > On Sun, 13 Jul 2008, Johannes Sixt wrote:
>> > > > @@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char
>> > > > *path)
>> > > >  	}
>> > > >  }
>> > > >
>> > > > -void setup_path(const char *cmd_path)
>> > > > +void setup_path(void)
>> > >
>> > > It seems to me that this patch would not do anything different, but
>> > > with less code change, if setup_path() would set argv0_path, and not a
>> > > new function was introduced.
>> >
>> > This is just to play a safe game. I had it that way, but I decided to
>> > have the call to the new git_set_argv0_path() early in git.c because the
>> > call to setup_path() in git.c is very late, and it could happen that we
>> > call system_path() (which needs argv0_path) before that. Although I
>> > didn't audit the code whether this really happens.
>>
>> Well, okay... I would have rather seen it not change (since there was no
>> bug to fix), or as a separate patch, but it's Junio's call.
>
> I investigated this, and, yes, there indeed are calls to system_path() before 
> setup_path(), for example:
>
>  commit_pager_choice
>    setup_pager
>      git_config
>        git_etc_gitconfig
>          system_path(ETC_GITCONFIG)
>
> Junio, do you want git_set_argv0_path() in a separate patch?

I think that would be easier to explain in the commit log what is going
on, if it is a separate patch.
