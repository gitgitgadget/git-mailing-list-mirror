From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] ls-remote: default to 'origin' when no remote specified
Date: Thu, 8 Apr 2010 14:07:11 +0800
Message-ID: <l2xbe6fef0d1004072307ma8dff5c2ic5dce170b28e5957@mail.gmail.com>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
	 <20100408044552.GA30473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 08:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzkta-00019t-5J
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 08:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0DHGHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 02:07:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56388 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab0DHGHM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 02:07:12 -0400
Received: by gyg13 with SMTP id 13so1010499gyg.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Lvml4S1AmXsB/0CKaSc0mVeK97RmkU+QEohYHSAwyuo=;
        b=dHqc3tD9XisLHM4HJTrr/sFxkkdEwxs7AO+ZDOunDZbzAbFI3iay6yzC866dubtuDL
         uO+GwwyrF5vcv0ZnK/yjIrivJahBsnXGvTPDiOFI7mYW1NQX7ILBR3s6mcj3241BCBbg
         kkwCSQEtx/N/yd+rxoMdsnF7XfdLZTI01Bn9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i2hyfiFxGYp8kqraHxcxWB4uRG2bmyeLnTnzHji/2G9g1Bv+ssegIE5rvGr5hyEQ7O
         ZgGiSnEJ8LV+itlV7hEoiIOjhFznAZ02Xm4gNiQnpjNVmhLnz21roMxdTLbKuH56JxOA
         Gk43ipR4ke8yGe/isO8hEVOhr7DgQ9fZ1WOQo=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 23:07:11 -0700 (PDT)
In-Reply-To: <20100408044552.GA30473@coredump.intra.peff.net>
Received: by 10.151.61.8 with SMTP id o8mr4188384ybk.57.1270706831362; Wed, 07 
	Apr 2010 23:07:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144322>

Hi,

On Thu, Apr 8, 2010 at 12:45 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 08, 2010 at 11:58:03AM +0800, Tay Ray Chuan wrote:
>
>> Instead of breaking execution when no remote (as specified in the
>> variable dest) is specified when git-ls-remote is invoked, continue =
on
>> and let remote_get() handle it.
>>
>> That way, we are able to use the default remote (by default, "origin=
"),
>> as git-fetch, git-push, and others, do.
>>
>> While we're at it, die with a more interesting message ("Where do yo=
u
>> want to..."), as git-fetch does, instead of the plain usage help.
>
> I don't really see a problem with this. The current behavior produces=
 an
> error, so it is not as if we are breaking somebody's workflow, and th=
e
> only sensible default is the same one used by the other commands.

I'm trying to make it behave like the other commands that deal with
remotes, such as git-fetch and git-push; when they are run without any
arguments, they default to "origin" or branch.<name>.remote.

Assuming that you and I are talking about the same "other commands",
than the default isn't an issue; the rules used to determine the
default remote is done in remote_get(), so they are similar.

>> + =A0 =A0 if (!remote)
>> + =A0 =A0 =A0 =A0 =A0 =A0 die("Where do you want to list from today?=
");
>
> Heh.

Do you think this is too light-hearted for ls-remote's role? If so,
I'll just revert back exiting with the usage text.

>> +test_expect_success 'dies with message when no remote specified and=
 no default remote found' '
>> +
>> + =A0 =A0 !(git ls-remote >actual 2>&1) &&
>> + =A0 =A0 test_cmp exp actual
>
> Use test_must_fail?

Noted.

>> +cat >exp <<EOF
>> +fatal: 'refs*master' does not appear to be a git repository
>> +fatal: The remote end hung up unexpectedly
>> +EOF
>> +test_expect_success 'confuses pattern as remote when no remote spec=
ified' '
>> + =A0 =A0 #
>> + =A0 =A0 # Although ugly, this behaviour is akin to the confusion o=
f refspecs for
>> + =A0 =A0 # remotes by git-fetch and git-push, eg:
>> + =A0 =A0 #
>> + =A0 =A0 # =A0 $ git fetch branch
>> + =A0 =A0 #
>> +
>> + =A0 =A0 # We could just as easily have used "master"; the "*" emph=
asizes its
>> + =A0 =A0 # role as a pattern.
>> + =A0 =A0 !(git ls-remote refs*master >actual 2>&1) &&
>> + =A0 =A0 test_cmp exp actual
>> +
>> +'
>
> This seems like a very odd thing to be testing. Should you not instea=
d
> test that "git ls-remote $foo" still treats $foo as a remote and list=
s
> it, which is what we really care about?

There are already existing tests to test "git ls-remote $foo" (unless
you mean '$' to have a special significance, like '*' does).

The test was to let current and future git hackers/users know that the
usage of <pattern> as the remote by git-ls-remote ("<pattern> does not
appear to be a git repository") is indeed expected behaviour.

--=20
Cheers,
Ray Chuan
