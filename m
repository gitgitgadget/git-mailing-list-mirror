From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/9] git p4 test: simplify quoting involving
 TRASH_DIRECTORY
Date: Tue, 26 Jun 2012 10:10:53 -0700
Message-ID: <20120626171053.GA31456@padd.com>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
 <1340673505-10551-4-git-send-email-pw@padd.com>
 <4FE95586.8090803@viscovery.net>
 <7vk3yuca42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 19:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjZPr-0000X4-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 19:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746Ab2FZRS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 13:18:59 -0400
Received: from honk.padd.com ([74.3.171.149]:47666 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758499Ab2FZRS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 13:18:58 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2012 13:18:58 EDT
Received: by honk.padd.com (Postfix, from userid 7770)
	id 804AD3309; Tue, 26 Jun 2012 10:10:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk3yuca42.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200661>

gitster@pobox.com wrote on Tue, 26 Jun 2012 09:26 -0700:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > Am 6/26/2012 3:18, schrieb Pete Wyckoff:
> >>  test_expect_success 'exit when p4 fails to produce marshaled output' '
> >> -	badp4dir="$TRASH_DIRECTORY/badp4dir" &&
> >> -	mkdir "$badp4dir" &&
> >> -	test_when_finished "rm \"$badp4dir/p4\" && rmdir \"$badp4dir\"" &&
> >> -	cat >"$badp4dir"/p4 <<-EOF &&
> >> +	mkdir badp4dir &&
> >> +	test_when_finished "rm badp4dir/p4 && rmdir badp4dir" &&
> >> +	cat >badp4dir/p4 <<-EOF &&
> >>  	#!$SHELL_PATH
> >>  	exit 1
> >>  	EOF
> >> -	chmod 755 "$badp4dir"/p4 &&
> >> -	PATH="$badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
> >> +	chmod 755 badp4dir/p4 &&
> >> +	PATH="$TRASH_DIRECTORY/badp4dir:$PATH" git p4 clone --dest="$git" //depot >errs 2>&1 ; retval=$? &&
> >>  	test $retval -eq 1 &&
> >
> > The long line here is severly broken, because the semicolon breaks the &&
> > chain; retval would be assigned to even if one of the earlier commands
> > fails, and that you don't want to treat as success. The least that is
> > needed is to put the line in braces. But I suggest to rewrite the two
> > lines above as
> >
> > 	(
> > 		PATH="$TRASH_DIRECTORY/badp4dir:$PATH" &&
> > 		export PATH &&
> > 		test_expect_code 1 git p4 clone --dest="$git" //depot >errs 2>&1
> > 	) &&
> >
> >>  	test_must_fail grep -q Traceback errs
> >
> > We don't expect that grep fails due to segfault or something. Write this
> > line as
> >
> > 	! grep Traceback errs
> >
> > Also drop the -q; if the test detects a failure, you do want to see the
> > grep output in a verbose test run.
> 
> All true.  Thanks for carefully reading.

Yes, both your reviews are quite appreciated.  I've got patches
ready for these and will plan to send out an updated series
tonight.

		-- Pete
