From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Thu, 10 May 2012 16:22:47 +0200
Message-ID: <CABPQNSbBwpVJUx9BSSO2nqAnPxUESZBz-GEqOPPEyqvdcutb6w@mail.gmail.com>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <4FA904C3.7070208@viscovery.net> <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
 <7vd36ey70y.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 16:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUHG-00086U-KV
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081Ab2EJOXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:23:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47092 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab2EJOX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 10:23:28 -0400
Received: by pbbrp8 with SMTP id rp8so1968124pbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Qckl4LM/mx9TeYo57L6aTs5gqQCKC/w0WhGr/pbvHho=;
        b=lx/Z9xpZ2jtGR1/ctMZM+65APJ/bNI7SklyqaJfH1auIzLfkGjVn3X1/vrdVCsA8p2
         PYU4UUKDCAX+Qudq8TzrljnxRbvwZZmZU4S0ElbeuyjxhdnM1CKuxy5z60cZ132isd9z
         s/ZUUJ7oPWPOoibJwgPEjUoLLGIsSWw18RfRWvSSrm8m4E5b2xzdPRzODGbjuRx1P8+K
         yZR7mnUxFZFh0MH7fWfX+P4m6ibTqcfbpIAb0+IAw7fZ92doMwLEql9DHMikDKYQoL4K
         F+2Wbe5U5TuwIooMawxakIvLmyi/P5RTY9YRiFZpaSyf7rFbGRKmu9tC5kbdMeTlk34H
         onTA==
Received: by 10.68.222.197 with SMTP id qo5mr568072pbc.72.1336659807374; Thu,
 10 May 2012 07:23:27 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Thu, 10 May 2012 07:22:47 -0700 (PDT)
In-Reply-To: <7vd36ey70y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197570>

On Tue, May 8, 2012 at 6:25 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> But if I apply the following patch, the test passes. I'm not saying
>> it's the right thing to do, though.
>>
>> (Warning: white-space damaged because of copying diffs between termi=
nals)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 23fc56d..d70e819 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1096,8 +1096,11 @@ int cmd_checkout(int argc, const char **argv,
>> const char *prefix)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int flag;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!read_ref_full("HEAD", rev, 0, &=
flag) &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (flag & REF_ISSYMREF) && is_nu=
ll_sha1(rev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (flag & REF_ISSYMREF) && is_nu=
ll_sha1(rev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!opts.new_branch)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return=
 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return switch_unborn=
_to_new_branch(&opts);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 return switch_branches(&opts, &new);
>> =A0}
>
> This patch, if we ignore submodules for a while, actually makes sense=
 to
> me. =A0If you have a commit, you are on that commit and you haven't d=
one
> anything since you have checked out that commit, "git checkout" (no o=
ther
> parameters) would be a no-op. =A0If you "git init" a repository, and =
you
> haven't done anything since then, the above makes "git checkout" (no =
other
> parameters) a no-op.

I agree. It does seem to make sense.

> Am I missing some corner cases that we _should_ error out, perhaps fo=
r the
> sake of safety?

I don't know, and I was kind of hoping someone would jump in and
enlighten me of something, but that didn't happen (yet).

I have a slight preference for this operation, though I'm not
religious; it simply seem more consistent with other "git checkout"
operation.

Do you want me to prepare a proper patch including a variation of the
test-case from the other patch?
