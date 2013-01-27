From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 09:34:53 -0800
Message-ID: <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
 <5105280A.80002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:35:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzW8X-0006Xg-0S
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 18:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab3A0Re5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 12:34:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3A0Rez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 12:34:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DEABB62;
	Sun, 27 Jan 2013 12:34:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5jfyn6vZ4OlP
	/7DH/Q3TFSp1D64=; b=rW6w/Swpbc59O2RHLaD3xtJwb9eLpLh+UX1TwypLl051
	mngc4JBvR8KV0fNFn2MDwypKuXzzD+xeicg1gYeaQzLvnixm/vHPUcrWNGqxpoXh
	nta+wLT+sJhgFHZyG247V6hJR2psUxVxNAs84B9UPltioif1VgDZqYv52XDdR9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oegyo3
	ZD94bRxR1yeicKuFBAs4UB7vlg4xdD00fcxDZlqgFH7mwA1QgAz0xcWc0tMKGTzN
	zvMBL+OXb5sWEAT/VX/gSEuZml0MavSoX9t53WBi+tPFj3m+Fq9bGVoX+rfH/q3H
	/C7ZavhoqZ7kjVsyXKI+hg//gZnaQujQrdyl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E69BB61;
	Sun, 27 Jan 2013 12:34:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1D55BB60; Sun, 27 Jan 2013
 12:34:54 -0500 (EST)
In-Reply-To: <5105280A.80002@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Sun, 27 Jan 2013 14:13:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCDA9D20-68A7-11E2-B851-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214709>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Back to the which:
> ...
> and running "make test" gives the following, at least in my system:
> ...

I think everybody involved in this discussion already knows that;
the point is that it can easily give false negative, without the
scripts working very hard to do so.

If we did not care about incurring runtime performance cost, we
could arrange:

 - the test framework to define a variable $TEST_ABORT that has a
   full path to a file that is in somewhere test authors cannot
   touch unless they really try hard to (i.e. preferrably outside
   $TRASH_DIRECTORY, as it is not uncommon for to tests to do "rm *"
   there). This location should be per $(basename "$0" .sh) to allow
   running multiple tests in paralell;

 - the test framework to "rm -f $TEST_ABORT" at the beginning of
   test_expect_success/failure;

 - test_expect_success/failure to check $TEST_ABORT and if it
   exists, abort the execution, showing the contents of the file as
   an error message.

Then you can wrap commands whose use we want to limit, perhaps like
this, in the test framework:

	which () {
		cat >"$TEST_ABORT" <<-\EOF
		Do not use unportable 'which' in the test script.
                "if type $cmd" is a good way to see if $cmd exists.
		EOF
	}

	sed () {
		saw_wantarg=3D must_abort=3D
                for arg
                do
			if test -n "$saw_wantarg"
                        then
				saw_wantarg=3D
                                continue
			fi
			case "$arg" in
			--)	break ;; # end of options
			-i)	echo >"$TEST_ABORT" "Do not use 'sed -i'"
				must_abort=3Dyes
				break ;;
                        -e)	saw_wantarg=3Dyes ;; # skip next arg
			-*)	continue ;; # options without arg
			*)	break ;; # filename
			esac
		done
		if test -z "$must_abort"
			sed "$@"
		fi
	}

Then you can check that TEST_ABORT does not appear in test scripts
(ensuring that they do not attempt to circumvent the mechanis) and
catch use of unwanted commands or unwanted extended features of
commands at runtime.

But this will incur runtime performace hit, so I am not sure it
would be worth it.
