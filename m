From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 04/10] ref-filter: skip deref specifier in match_atom_name()
Date: Tue, 1 Dec 2015 18:11:54 -0500
Message-ID: <CAPig+cTNshvpwn1=VSbnDE8AQMkfKmd1wnP0hNLT1iS3cDEb_A@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 00:12:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3u5b-0008A9-0P
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 00:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbbLAXL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 18:11:58 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35725 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149AbbLAXLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 18:11:55 -0500
Received: by vkha189 with SMTP id a189so14277152vkh.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 15:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=F447KmA0Iab+OzRJi7XWxLLMCwP1RI6/DVuYfpZl1Bk=;
        b=PUB14Mr5t6/pDaY9n02TxTyzeoYav8/G4Q+cpw+5ImNJnrXdzRgz0WxOgI41rhp2yH
         KEiduhalOYskD+tfvmTukYTkyK4WfeJlKml5BzcuS6jlR0F5C/FkiTgyYil9oeKGoDOE
         D8UpT7A2q8RN4cgD0x7Bh3jOLamZ2m/UpkrJAoNtog8D7Ytv5RrImHkBuUykWtW35++/
         KWg4Y4jd52cRQXve9ISWFPc8FMFDvlFBj6Zrf9Zyq6nmiK4d1xPuHylfvx3t7AJf9nBG
         /n8vtysE2l8lNFeod+GkOby11I/8h9l+jv3ScLQhZR9+kfKmHjXvK1YAGboe7qq8oj/p
         OmVQ==
X-Received: by 10.31.13.205 with SMTP id 196mr59949988vkn.37.1449011514998;
 Tue, 01 Dec 2015 15:11:54 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 1 Dec 2015 15:11:54 -0800 (PST)
In-Reply-To: <1447271075-15364-5-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: H587dMynUMTOXgTBDjUluZ0kMt4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281862>

On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>

A bit of explanation about why this change is desirable would be
welcome. I'm guessing it's because a future patch is going to make
calls to match_atom_name() with the '*' deref indicator still attached
to the name, whereas existing code does not do so.

> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -37,6 +37,10 @@ static int match_atom_name(const char *name, const char *atom_name, const char *
>  {
>         const char *body;
>
> +       /*  skip the deref specifier*/
> +       if (name[0] == '*')
> +               name++;
> +
>         if (!skip_prefix(name, atom_name, &body))
>                 return 0; /* doesn't even begin with "atom_name" */
>         if (!body[0]) {
> --
> 2.6.2
