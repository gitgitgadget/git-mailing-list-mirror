X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Wed, 08 Nov 2006 17:10:19 -0800
Message-ID: <7vwt65pgqs.fsf@assigned-by-dhcp.cox.net>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net>
	<200611090104.32247.jnareb@gmail.com>
	<7v1wodqxux.fsf@assigned-by-dhcp.cox.net>
	<200611090146.25306.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 01:10:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611090146.25306.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 9 Nov 2006 01:46:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31173>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhyQz-0006tD-6b for gcvg-git@gmane.org; Thu, 09 Nov
 2006 02:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423980AbWKIBKW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 20:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423981AbWKIBKV
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 20:10:21 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:11697 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1423980AbWKIBKU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 20:10:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109011020.BOOR7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 20:10:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kRAR1V00M1kojtg0000000; Wed, 08 Nov 2006
 20:10:26 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> 1. First, esc_path should _not_ use subroutine which does it's own 
>>> contol characters escaping. That was also a mistake I made in my patch.
>>> Perhaps we should have some quot_html or to_html subroutine which does 
>>> _only_ to_utf8 (decode from Encode module), escapeHTML and optionally 
>>> s/ /&nbsp;/g conversion.
>> 
>> I hated that original arrangement, 
>
> What did you hate, again?

esc_path calling esc_html you mentioned, of course.


>> obviously wrong in the output with the patch you are responding
>> to.  Except that git_blame2 is missing a chomp() on "my $data"
>> after finishing the metainfo loop, that is.
>
> The original (mine) code for esc_path uses esc_html, which did it's
> own partial (very partial) special characters esaping, namely
> \014 (\f) => ^L, \033 (\e) => ^[. So if pathname had form feed character,
> it would be replaced by ^L, not '\f'.

I know -- that is what I meant by "code reuse and consistency".

> You have added quot_cec to esc_html subroutine directly. I don't know
> what is your version of esc_html after the changes you
> made,...

See "pu".

> Well, the pathname has the limit that it must be in single line
> after quoting. The "blob" output is multipage.

I honestly have _no_ idea what distincition you are seeing
here.  Both blob and diff output are processed one line at a
time and its result would be on a single line too.
