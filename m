From: Stefan Beller <sbeller@google.com>
Subject: Re: pre-push hook does not get input on non-fast-forward pushes
Date: Mon, 28 Mar 2016 14:56:49 -0700
Message-ID: <CAGZ79kbua6zgS3wkd9UKASDknxostFcBb_EWsVQ2WNaGeKw=2w@mail.gmail.com>
References: <201603282056.u2SKuqDf031459@mail2.student.tuwien.ac.at>
	<xmqq1t6uxop7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 23:57:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akf9p-0004tf-7p
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbcC1V4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 17:56:53 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35416 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbcC1V4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 17:56:50 -0400
Received: by mail-io0-f180.google.com with SMTP id g185so388507ioa.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 14:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5TjsKusWwQos7OdQkfnjUx58y+m9SnupKNHHJ9r2gng=;
        b=RzhBqjDGtanHUoZ9N5Vaz0VaBS9mthYBcca1syRGjUxSkIfuuqhsgniPjlpiixPACu
         38bgVaA5E/emya561sIhawP/bTyheKyZPBkFkE9LnqheccN31YX2mHdJ01GLRDbtrAhh
         1Y+hfHHrcB9kiYa7zBHIBvuSy+JRWi3KR5ycalZdzUQGrQGBFVsI22JDwR6Q3Vo23xoK
         4P5oOZvIVunAiVXwlGbSH8lOAoR6pJ1eY9c+V3gcXH2JsNRSncYyUUHlWuu6G2LqhfsR
         Auf10/MsDUdLaiA89kY8CZoETC3TwUr1EBczuRcVx7VSBOO0jkUgOnKNebQH6owf5w8A
         kJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5TjsKusWwQos7OdQkfnjUx58y+m9SnupKNHHJ9r2gng=;
        b=VE9cV29n8i8n808f9lWJMdRmCtVTOXwmA0RnkEsXldxQmoA7S21rpBdP5XDF1notRl
         QUOBtZdht0ThaRHVHCMCHQa9Jx9WPLzaP2EmkhGmUUXAGtlCoq9egXDy6OKyHnu362zE
         UPBXmQ8eHuskL7FjiZeI0O3PwrXToN8Ou7JHhM6uGv+UHn06j3UlgoDKcp5YRZbboamP
         qSArtjAAPQ2aChr9eaY9E6r6oW/sZ5gC7w4f1j0eew1ORptBFtj5KVIYcEiakwzVj6ef
         Ojt7Y8C0BLUXymRR/6IZtMI3EdMdhdwQ+FHp3GTvHWYZuBXv9SBRejhxaAJiXOcl+vIi
         dDjA==
X-Gm-Message-State: AD7BkJI+Vd2yCgWn2Kg3KwZdKEWVNcLBpSaKtgUmNWHLTbBjpqb/hknWUNXrNqKzUsHBhD9M+nzo+3eLHn4gm1pv
X-Received: by 10.107.184.8 with SMTP id i8mr6900339iof.96.1459202209346; Mon,
 28 Mar 2016 14:56:49 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 28 Mar 2016 14:56:49 -0700 (PDT)
In-Reply-To: <xmqq1t6uxop7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290066>

On Mon, Mar 28, 2016 at 2:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Tauner <stefan.tauner@alumni.tuwien.ac.at> writes:
>
>> I noticed that without an additional --force the pre-push hook does not
>> get any input on stdin if a push would result in non-fast-forward
>> uploads. This is not a problem per se (although I don't get the
>> rationale) but it is undocumented and the latter left me puzzled.
>>
>> (Please keep me in CC since I am not subscribed, thanks)
>
> Thanks (no need to say "please cc me", as that is the norm here).
>
> The pre-push hook is not the only thing that may prevent you from
> pushing a ref update.  As you noticed, non-fast-forward check may
> trigger and decide that a ref is not going to be pushed, and that
> may happen before we call the pre-push hook.
>
>     Information about what is to be pushed is provided on the hook's
>     standard input with lines of the form ...
>
> So when the pre-push is called, the refs that will not fast-forward
> may not be among the "what is to be pushed", hence not reported.
>
> We _could_ add something like this to the documentation, but we do
> not necessarily want to promise that the order of checks to stay
> "internal checks like non-ff check first before pre-push hook", so
> this update may not be an improvement.  The current text conveys
> enough information without making such a promise, but you need to
> read it carefully.
>
> So I dunno.
>
>  Documentation/githooks.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 9ef2469..605ba4d 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -201,7 +201,9 @@ does not yet exist the `<remote SHA-1>` will be 40 `0`.  If a ref is to be
>  deleted, the `<local ref>` will be supplied as `(delete)` and the `<local
>  SHA-1>` will be 40 `0`.  If the local commit was specified by something other
>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it will be
> -supplied as it was originally given.
> +supplied as it was originally given.  A request to update remote ref that has
> +already been rejected for other reasons (e.g. failing to pass a fast-forward
> +test) does not appear in the input.

If we don't want to give promises, s/does not/ may not/ ?

Although that sounds like it is non-deterministic (some occur, some don't,
maybe it depends on $random_reason)

>
>  If this hook exits with a non-zero status, 'git push' will abort without
>  pushing anything.  Information about why the push is rejected may be sent
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
