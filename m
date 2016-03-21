From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: merge: fix NULL pointer dereference when merging nothing into void
Date: Mon, 21 Mar 2016 15:36:45 -0400
Message-ID: <CAPig+cQjt==AKTWfCk6kzgVciGVb9XtKNiwPK14nPM7=4yhmjQ@mail.gmail.com>
References: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
	<1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br>
	<xmqq7fgvmz8o.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5dF-0003zx-KQ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbcCUTgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:36:48 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35804 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757735AbcCUTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:36:46 -0400
Received: by mail-vk0-f53.google.com with SMTP id e6so227498822vkh.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=1M8s6BwFf195AUS9BktYTd24idSR8oHp4d6snTU7DCg=;
        b=SM331oM4YWU21RFWrxViZZV5rAd3XhqP1Loy5FruAmzaM4luAw/AM0HC+fonAlfbby
         Z2gIW/pylTMrt1TpS+82cCN+l0OQD2QWyMHUQhM10M3hZYOqiEI80rSCieBgOthU7eMS
         Z+uQQxzBaJpjQKTNBan4dH9fk+K4N1jy8UYkZZJ5YV538Z78XYij43jipORRVmUWsPDe
         2/jkx7NXAoR0Kp3jhvhirr7VH6jynEy7cgYvSFMGycFVDZRKNg+MsksyRY/iOkgtrYTI
         kHUqU7yFzmPug8yGPJjUr5I1qDZMjPZpMyQgfflzp/gCugdhR7d48bJofsPbguJGtV25
         3qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1M8s6BwFf195AUS9BktYTd24idSR8oHp4d6snTU7DCg=;
        b=OK9U/T1px9VjB5MSO/wHGDXXx6J5I7wuDIgTvV9e+RMlyCUwYW1OIT4C/j8DY8QIC0
         Wv0LLfJ8OexUeW5j816fbAD2CnscRavdirVNMTPQkfjZb8sXYmFagRGr/RNXyzJ4vTsP
         RhQqEqoWDKJQiGEOVzg0gO/SFS/WnSTYGsv7Xp7FcL54eCE5VGa6hs6uEgunzx+Xgz+q
         w0W0jfl1RETwaj6vwbZm6y744MDea4ENh6Zeolj7MB03/Ow5sCMzWi26Tbe110Tx3PMp
         QaObF3fDMnybalye+GbcDgGL+3wdyJFrKE5IFyESHw5EhslaUOKY6M+R7mpqtEDrHIiG
         CSbg==
X-Gm-Message-State: AD7BkJJX5wxmc0hgaK7wXUG2Gpi+kCR2d2F0ZwYDl8U+tvY2AczjG9/Ilnix9rS8qEJZG6FFiqJl7Pw3VY46TA==
X-Received: by 10.31.150.76 with SMTP id y73mr32984231vkd.84.1458589005769;
 Mon, 21 Mar 2016 12:36:45 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 12:36:45 -0700 (PDT)
In-Reply-To: <xmqq7fgvmz8o.fsf_-_@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: mfdMceRF_Fh1m9lh1N0VfY_33Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289445>

On Mon, Mar 21, 2016 at 3:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When we are on an unborn branch and merging only one foreign parent,
> we allow "git merge" to fast-forward to that foreign parent commit.
>
> This codepath incorrectly attempted to dereference the list of
> parents that the merge is going to record even when the list is
> empty.  It must refuse to operate instead when there is no parent.
>
> All other codepaths make sure the list is not empty before they
> dereference it, and are safe.
>
> Reported by Jose Ivan B. Vilarouca Filho
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> @@ -725,4 +725,14 @@ test_expect_success 'merge detects mod-256 conflicts (resolve)' '
> +test_expect_success 'merge nothing into void' '
> +       git init void &&
> +       (
> +               cd void &&
> +               git remote add up .. &&
> +               git fetch up &&
> +               test_must_fail git merge FETCH_HEAD

Ah, nice. I either didn't know or had forgotten that test_must_fail is
smart enough to detect unexpected failures (such as segfault), so my
advice to Jose about capturing stderr[1] was misdirected. Thanks.

[1]: http://article.gmane.org/gmane.comp.version-control.git/289405

> +       )
> +'
> +
>  test_done
