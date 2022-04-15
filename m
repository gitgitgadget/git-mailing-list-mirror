Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFB5C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 02:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbiDOCjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiDOCjn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 22:39:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383754BB9B
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:37:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p10so6154390plf.9
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dkn6ktXGQ4yj5bnVpvMvy1GnDOZ9BglaafT7mixPWbw=;
        b=YSJ7ec8W1COb6X5aLZxkySwF7fJ8ggvgXjZfnUdtdKtjV8mkAy1BY3Cu6pzUyAeHVY
         5TsHrKEWNV4RnRslTJk+xn7eLgQ04cX3Axp0yoQ5DLQBlcxmUI0llBSu4oEJstB5TJ70
         DbNeTCdqOB+vvWv7KSLzYctykX4InTjPrNt8kJCA9XB2DOuz3DF5HNDNn7aIUmeiQprk
         hcHpglJFj7YPNi4tN20z1w4L94xyPQb1q4xxq1WIWao5CsIg8phJwWXAMlQ0cvMpJHnF
         BYJfZOTN/BCD+lfFBAYE02dhzUYqAUTOfbLSaM+6JXBLyVzeSlOakcM2lSkRSf0aCBJA
         htag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dkn6ktXGQ4yj5bnVpvMvy1GnDOZ9BglaafT7mixPWbw=;
        b=76b7EkOS3EyImPsPTcW1/33/so8rXuVQRdoNNod7Wl4acux95wmsqIUjWjGAPSbUOX
         gM59I8nMp6h0R9M5E4Tl6RyY08Mb658jdksyzoEw3GiMMMblrwHVHYVjzuKb46CqaD30
         38cACFB80T3BSfKLlhnzjpndWFfU4PqDDLWy2nxC52m/sWx+yHLAEwz9HyMEoqKnm9c3
         ii4BZyhalSWKewYimubs8MjIjRM8h0V0R3fWmV1SeCdFpLu01gVH30bOQ05uZfag9Ka2
         JnF6J2+47VkqisUuwZjZDHQvAG2kiw8ooMy6fv/ExHEfJOzXO/eGlYZusPhqsNjpUP2R
         rhbA==
X-Gm-Message-State: AOAM533BVxiDLKst0jtXVz7c7BEM7gqXIHiL1e1crqS0nrW6emOhZLx7
        KM5qh1eYL7NuVziGGPQx1ZSLDRBp6habfimtniYU5A==
X-Google-Smtp-Source: ABdhPJxBMvflqXGjb76UwykijKvunnN7H0qdix6KZLS8kcrn75iloyx54mdlqYpQygux+xUY3JsnbcVxteB+cYbMmRc=
X-Received: by 2002:a17:903:1205:b0:151:8ae9:93ea with SMTP id
 l5-20020a170903120500b001518ae993eamr50168156plh.37.1649990235936; Thu, 14
 Apr 2022 19:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com> <xmqq4k2w92xo.fsf@gitster.g>
In-Reply-To: <xmqq4k2w92xo.fsf@gitster.g>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 14 Apr 2022 19:37:04 -0700
Message-ID: <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
Subject: Re: reference-transaction regression in 2.36.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000e5a42405dca849f0"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000e5a42405dca849f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2022 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > This does look lik a series regression.
>
> Yes.
>
> > I haven't had time to bisect this, but I suspect that it'll come down t=
o
> > something in the 991b4d47f0a (Merge branch
> > 'ps/avoid-unnecessary-hook-invocation-with-packed-refs', 2022-02-18)
> > series.
>
> With the issue that /var/tmp/.git can cause trouble to those who
> work in /var/tmp/$USER/playpen being taken reasonably good care of
> already, it seems this is the issue with the highest priority at
> this point.
>
> > I happen to know that Patrick is OoO until after the final v2.36.0 is
> > scheduled (but I don't know for sure that we won't spot this thread &
> > act on it before then).
> >
> > Is this something you think you'll be able to dig into further and
> > possibly come up with a patch? It looks like you're way ahead of at
> > least myself in knowing how this *should* work :)
>
> Thanks.

One of my colleagues was able to spend some further time investigating
this. He also experimented with commands other than "git branch -d"
and found that "git update-ref -d", for example does not exhibit the
issue, but "git tag -d" does. Storing a replay of the various
reference-transaction callbacks shows that for every command _other
than_ "git branch -d" and "git tag -d", pre-2.36 reference
transactions follow the pattern "prepared", "prepared", "committed",
"committed". "git branch -d" and "git tag -d", on the other hand, go
"prepared", "committed", "prepared", "committed". This implies the
reference-transaction behavior is _already broken_ in 2.35, and the
changes in 2.36 to suppress packed callbacks just make it more
obvious.

For reference, here are the reference-transactions for _2.35_ using
"git branch -d" and "git update-ref -d". In both runs, the ref only
exists packed--there is no loose ref to delete. My
reference-transaction script is simple:
$ cat .git/hooks/reference-transaction
echo "-- $1"
cat
git rev-parse refs/heads/to-delete --
exit 0

 $ git-2.35.1 branch -d to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
-- aborted
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was 1767344).

$ git-2.35.1 update-ref -d refs/heads/to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'

Now, the same two scenarios in 2.36.0-rc2:

$ git-2.36.0-rc2 branch -d to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was 1767344).

$ git-2.36.0-rc2 update-ref -d refs/heads/to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'

Looking at the data this way makes it more obvious that the issue
isn't actually new in 2.36; even in 2.35, the branch is fully deleted
before the _loose_ transaction is prepared, with "git branch -d".
Since "git update-ref -d" prepares both transactions before committing
either, the branch still exists in both "prepared" callbacks. The real
difference here, between 2.35 and 2.36, is that Bitbucket Server (and,
ostensibly, other reference-transaction users), with enough checking,
can essentially pick-and-choose between "prepared" and "committed"
callbacks to cobble together a working pairing: For "git branch -d",
we replicate on the first "prepared" and wrap up replication on the
_second_ "committed", and for "git update-ref -d" we replicate on the
_second_ "prepared" and wrap up on the _second_ "committed". Since the
packed callbacks are gone in 2.36, that's not possible.

The attached patch on top of the v2.36.0-rc2 tag fixes the issue, and
all of the t14xx tests (including t1416) pass (aside from known
issues). (Apologies for attaching the patch rather than inlining it;
the Gmail editor butchers it if I try that.) With the patch applied,
the reference-transaction callbacks are identical to 2.36.0-rc2, in
terms of when they run, but the state of the ref is different:

$ git-patched branch -d to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'
Deleted branch to-delete (was 1767344).

$ git-patched update-ref -d refs/heads/to-delete
-- prepared
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
1767344659fd3f7a6b788020203f74baeea0e0f7
--
-- committed
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/to-delete
fatal: bad revision 'refs/heads/to-delete'

Now "git branch -d" and "git update-ref -d" have the same callbacks,
and see the same ref state in each.

I'm happy to try and format this into a proper patch, with sign-offs
and new tests, if folks think this is the way to go. If the 2.36
release cycle is too far along, I can still try and get a patch to the
list for inclusion in 2.37 (though I'm less confident what commit I'd
base the patch on in that scenario). Any pointers would be
appreciated. (Or, if someone with more familiarity than me, not to
mention a patch submission setup that already works, wants to take
over, that's fine too.)

Best regards,
Bryan Turner

--000000000000e5a42405dca849f0
Content-Type: application/octet-stream; name="files-delete-ref.patch"
Content-Disposition: attachment; filename="files-delete-ref.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l1zsqkew0>
X-Attachment-Id: f_l1zsqkew0

ZGlmZiAtLWdpdCBhL3JlZnMvZmlsZXMtYmFja2VuZC5jIGIvcmVmcy9maWxlcy1iYWNrZW5kLmMK
aW5kZXggOTVhY2FiNzhlZS4uYzExYWJlZjE4NiAxMDA2NDQKLS0tIGEvcmVmcy9maWxlcy1iYWNr
ZW5kLmMKKysrIGIvcmVmcy9maWxlcy1iYWNrZW5kLmMKQEAgLTEyNzMsMjkgKzEyNzMsMTIgQEAg
c3RhdGljIGludCBmaWxlc19kZWxldGVfcmVmcyhzdHJ1Y3QgcmVmX3N0b3JlICpyZWZfc3RvcmUs
IGNvbnN0IGNoYXIgKm1zZywKIAlpZiAoIXJlZm5hbWVzLT5ucikKIAkJcmV0dXJuIDA7CiAKLQlp
ZiAocGFja2VkX3JlZnNfbG9jayhyZWZzLT5wYWNrZWRfcmVmX3N0b3JlLCAwLCAmZXJyKSkKLQkJ
Z290byBlcnJvcjsKLQotCXRyYW5zYWN0aW9uID0gcmVmX3N0b3JlX3RyYW5zYWN0aW9uX2JlZ2lu
KHJlZnMtPnBhY2tlZF9yZWZfc3RvcmUsCi0JCQkJCQkgIFJFRl9UUkFOU0FDVElPTl9TS0lQX0hP
T0ssICZlcnIpOwotCWlmICghdHJhbnNhY3Rpb24pCi0JCWdvdG8gZXJyb3I7Ci0KLQlyZXN1bHQg
PSBwYWNrZWRfcmVmc19kZWxldGVfcmVmcyhyZWZzLT5wYWNrZWRfcmVmX3N0b3JlLAotCQkJCQkg
dHJhbnNhY3Rpb24sIG1zZywgcmVmbmFtZXMsIGZsYWdzKTsKLQlpZiAocmVzdWx0KQotCQlnb3Rv
IGVycm9yOwotCi0JcGFja2VkX3JlZnNfdW5sb2NrKHJlZnMtPnBhY2tlZF9yZWZfc3RvcmUpOwot
CiAJZm9yIChpID0gMDsgaSA8IHJlZm5hbWVzLT5ucjsgaSsrKSB7CiAJCWNvbnN0IGNoYXIgKnJl
Zm5hbWUgPSByZWZuYW1lcy0+aXRlbXNbaV0uc3RyaW5nOwogCi0JCWlmIChyZWZzX2RlbGV0ZV9y
ZWYoJnJlZnMtPmJhc2UsIG1zZywgcmVmbmFtZSwgTlVMTCwgZmxhZ3MpKQorCQlpZiAocmVmc19k
ZWxldGVfcmVmKHJlZl9zdG9yZSwgbXNnLCByZWZuYW1lLCBOVUxMLCBmbGFncykpCiAJCQlyZXN1
bHQgfD0gZXJyb3IoXygiY291bGQgbm90IHJlbW92ZSByZWZlcmVuY2UgJXMiKSwgcmVmbmFtZSk7
CiAJfQotCi0JcmVmX3RyYW5zYWN0aW9uX2ZyZWUodHJhbnNhY3Rpb24pOwogCXN0cmJ1Zl9yZWxl
YXNlKCZlcnIpOwogCXJldHVybiByZXN1bHQ7CiAK
--000000000000e5a42405dca849f0--
