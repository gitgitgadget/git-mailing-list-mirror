From: =?KOI8-R?B?98HTyczJyiDtwcvB0s/X?= <einmalfel@gmail.com>
Subject: Re: [PATCH 1/2] merge-base: fix duplicates and not best ancestors in output
Date: Tue, 31 Dec 2013 15:15:56 +0400
Message-ID: <CABEtfDEVfmrTrsAUqY75NfBPYJpWA-YVouYJDktn5ovkjg_Vtw@mail.gmail.com>
References: <CABEtfDFu=Fc0SXbyFctEyiMCJwqxP25K9mdVhAB0X_vKHxvW_A@mail.gmail.com>
	<xmqqppoerwnm.fsf@gitster.dls.corp.google.com>
	<xmqqy532qf23.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 31 12:16:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxxIp-0003Qw-5F
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 12:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab3LaLP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Dec 2013 06:15:59 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35604 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab3LaLP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Dec 2013 06:15:58 -0500
Received: by mail-wg0-f44.google.com with SMTP id a1so10770911wgh.23
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 03:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ceR1yZZCvTBNG0KLHjsDpXEkLY4dRfYmdnZ+sLli9ag=;
        b=RZlQhyPOxb8nw0uKnkrpXb0MGzlXI2NlJLMKkx4tVHJlpFz/ejJSJToo6sBu/xS4gN
         Bz9kZkOFJ87LNjCS/ned72PjHQ9hFyFWHidN+soAw4p/7OBwayzBfdQxkuPkSZjBgeQ6
         n7pGQb32l0sD7uaLphCIOKtt+VwDEf8KP45OKF3FXdi1qWGFCd6MtkstBSn5Xh7NhP16
         ZQpWPRWqBZ2ZQtxcn4kTqGHNQui3lg6z2m5Na+sEhHGUvEp9XrZP0Edm1iCKy40sDFRf
         ZOCoHl/oLeQRsZZqKyaDsER7K6IK+kf5vhoqx5Tp2Z92xGTkl6NTAnFUkXs+GPwt7j7L
         qeRg==
X-Received: by 10.180.76.103 with SMTP id j7mr25694077wiw.58.1388488556962;
 Tue, 31 Dec 2013 03:15:56 -0800 (PST)
Received: by 10.194.123.228 with HTTP; Tue, 31 Dec 2013 03:15:56 -0800 (PST)
In-Reply-To: <xmqqy532qf23.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239837>

Hello, Junio!

>> Hi there!
>> First of all: I'm new to mailing-lists, sorry if I'm doing it wrong.
>>
>> I've found a bug in git merge-base, causing it to show not best comm=
on
>> ancestors and duplicates under some circumstances (example is given =
in
>> attached test case).
>
>Attached???

Sorry about this. I expected my first message to be sent back to me by
git@vger.kernel.org. As I understand I should have replied to this
message with second patch (test). But I did not received first message
back, so I just sent second one to git@vger.kernel.org. What am I
doing wrong?

> I think we should split that helper function
> handle_octopus().  It does two totally unrelated things

Agree! I have not done this in original patch because I wanted it to
be a minimal change.

> And assuming that deduping is the right thing to do here, here is a
> follow-up on top of the spliting patch.
>
> Scripts that use "merge-base --octopus" could do the reducing
> themselves, but most of them are expected to want to get the reduced
> results without having to do any work themselves.

Not sure what scripts you are talking about. Man git merge-base says:
"--octopus
           Compute the best common ancestors of all supplied commits"
Without deduping this option doesn't always work, so it is a right
thing to do here.

I've also tested changes you've sent, they are OK.

Happy new year!

2013/12/31 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I do not offhand remember if it was deliberate that we do not dedup
>> the result from the underlying get_octopus_merge_bases() (the most
>> likely reason for not deduping is because the caller is expected to
>> do that if it wants to).
>>
>> Whether it is an improvement to force deduping here or it is an
>> regression to do so, I think we should split that helper function
>> handle_octopus().  It does two totally unrelated things (one is only
>> to list independent heads without showing merge bases, the other is
>> to show one or more merge bases across all the heads given).
>> Perhaps if we split the "independent" codepath introduced by
>> a1e0ad78 (merge-base --independent to print reduced parent list in a
>> merge, 2010-08-17) into its own helper function, like this, it would
>> make it clear what is going on.
>
> And assuming that deduping is the right thing to do here, here is a
> follow-up on top of the spliting patch.
>
> -- >8 --
> Subject: [PATCH] merge-base --octopus: reduce the result from get_oct=
opus_merge_bases()
>
> Scripts that use "merge-base --octopus" could do the reducing
> themselves, but most of them are expected to want to get the reduced
> results without having to do any work themselves.
>
> Tests are taken from a message by =F7=C1=D3=C9=CC=C9=CA =ED=C1=CB=C1=D2=
=CF=D7
> <einmalfel@gmail.com>
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  We might want to vet the existing callers of the underlying
>  get_octopus_merge_bases() and find out if _all_ of them are doing
>  anything extra (like deduping) because the machinery can return
>  duplicate results. And if that is the case, then we may want to
>  move the dedupling down the callchain instead of having it here.
>
>  builtin/merge-base.c  |  2 +-
>  t/t6010-merge-base.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index daa96c7..87f4dbc 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -73,7 +73,7 @@ static int handle_octopus(int count, const char **a=
rgs, int show_all)
>         for (i =3D count - 1; i >=3D 0; i--)
>                 commit_list_insert(get_commit_reference(args[i]), &re=
vs);
>
> -       result =3D get_octopus_merge_bases(revs);
> +       result =3D reduce_heads(get_octopus_merge_bases(revs));
>
>         if (!result)
>                 return 1;
> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index f80bba8..abb5728 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -230,4 +230,43 @@ test_expect_success 'criss-cross merge-base for =
octopus-step' '
>         test_cmp expected.sorted actual.sorted
>  '
>
> +test_expect_success 'merge-base --octopus --all for complex tree' '
> +       # Best common ancestor for JE, JAA and JDD is JC
> +       #             JE
> +       #            / |
> +       #           /  |
> +       #          /   |
> +       #  JAA    /    |
> +       #   |\   /     |
> +       #   | \  | JDD |
> +       #   |  \ |/ |  |
> +       #   |   JC JD  |
> +       #   |    | /|  |
> +       #   |    |/ |  |
> +       #  JA    |  |  |
> +       #   |\  /|  |  |
> +       #   X JB |  X  X
> +       #   \  \ | /   /
> +       #    \__\|/___/
> +       #        J
> +       test_commit J &&
> +       test_commit JB &&
> +       git reset --hard J &&
> +       test_commit JC &&
> +       git reset --hard J &&
> +       test_commit JTEMP1 &&
> +       test_merge JA JB &&
> +       test_merge JAA JC &&
> +       git reset --hard J &&
> +       test_commit JTEMP2 &&
> +       test_merge JD JB &&
> +       test_merge JDD JC &&
> +       git reset --hard J &&
> +       test_commit JTEMP3 &&
> +       test_merge JE JC &&
> +       git rev-parse JC >expected &&
> +       git merge-base --all --octopus JAA JDD JE >actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 1.8.5.2-311-g6427a96
>
