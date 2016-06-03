From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sat, 4 Jun 2016 06:52:23 +0700
Message-ID: <CACsJy8DV5aqsxM9+QZ+5d2fMLYF4foBnAxmyiYHOLtqzvS3QGQ@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <20160603170621.GA3858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8ytf-0007pu-7m
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbcFCXwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 19:52:55 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:38498 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbcFCXwy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 19:52:54 -0400
Received: by mail-it0-f43.google.com with SMTP id i127so4876655ita.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2orRKLT8SbAiLWuyGh5+499Su7zygIi11OrkISU80D8=;
        b=i4OjH9+A0pJm5P6p4lbJ60jrKWyTTb3bFBJe9Ay4j+bnWWkhzKmexUiyG/p6wBacTm
         EZMFJvy4/8wjiH5Xf5HStLWh0C2/dWCbw+Tx4Am4NBXcHhQkNahbO1nxQSB03TdQSDL3
         7x6BkiOHgnqBYbK/Di0XFtDqvnsIdLoW3P2qFzmCPnqEsjD+PeejfRwCMl++Ie1YMdnt
         dga1w1x+EKKyEGVHI1WLU6SZMufgf7jKwGY4QagQ83WBO6gYXhSzuJ0SfJZhIEXuWPoI
         AjjrqeJzOXTuhP+qMulPVVx/0lR92dBL/1hOFZ3bAUk8+5bt09bDvCwYQ3E0+849FduF
         wI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2orRKLT8SbAiLWuyGh5+499Su7zygIi11OrkISU80D8=;
        b=VuUNnv7eJ104qhSD5YQ6yXoHJ5GKCBnsIS0HFWyI/VYPTBg8m9xdYtNsmD+IdKiVXb
         224ghQRaU5z4g65Xyvjw+7tZdigrzmcMkWneNRxO7x2KhhwP1wPuyvF9ij/R5zZ8saKs
         lSi29IuVY7e1pq7/2AwP6ozAUqIMF1BNtdcgiP9okPdC7zn7uIeiS1QBSlsdN41DgAqy
         V6SzVz1w6B4b3EZC+FKUa9T9ynvuOIgGLext3PL58why68mqDkC9DgpL/SrvU7kFhX9w
         YSGbuxzYFa1eAAjny84QyBXtzlMbBhU+tBH3CUzXdYfoLCutuLcphJBS35HgUpAi82OB
         1Gbw==
X-Gm-Message-State: ALyK8tLqzptiEO/h3OugiNj9oAFO8D7rO/K05EVDOMexA7Qin0UoZRN4AoyVan3l9ve4iihUK/9Pk2yVmulyPg==
X-Received: by 10.36.130.130 with SMTP id t124mr3147042itd.42.1464997973513;
 Fri, 03 Jun 2016 16:52:53 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Fri, 3 Jun 2016 16:52:23 -0700 (PDT)
In-Reply-To: <20160603170621.GA3858@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296433>

On Sat, Jun 4, 2016 at 12:06 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 03, 2016 at 06:08:43PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> When there are lots of ref updates, each has different name length, =
this
>> will make it easier to look because the variable part is at the end.
>
> Is it worth handling more complicated cases, where there is a similar
> "middle", but different beginning?
>
> One of my common refspecs is:
>
>   +refs/pull/*/head:refs/remotes/pull/*
>
> That still shows as:
>
>   refs/pull/123/head -> pull/123
>
> but could be:
>
>   {refs -> }/pull/123{head -> }
>
> I actually think that _isn't_ an improvement, but I wonder if there i=
s a
> format that would be.

A placeholder can still keep the variable part at the end, e.g.
"refs/$/head -> pull/123"
--=20
Duy
