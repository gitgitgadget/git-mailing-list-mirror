From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 24 May 2016 17:55:02 -0700
Message-ID: <CAPc5daV4Z0gvaOL1H-v-G7RepGyiuir_AnzNx32aM3j2pm0RGw@mail.gmail.com>
References: <20160524194814.GA12479@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed May 25 02:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5N6c-0005IF-W9
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 02:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbcEYAzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 20:55:23 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33117 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbcEYAzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 20:55:22 -0400
Received: by mail-yw0-f175.google.com with SMTP id h19so33353598ywc.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 17:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gH8Qs1XglGufegKR6TcUvOZCrGydkdLUPIUoY4Wzys0=;
        b=XVmTh4VFdFh5Ecxedfk5BibV1LHnUWMtm8qTQBTJ2ccldZzWnvETzfVveAMFWM1sJy
         F49iGpFKOADlrjJD2Z7xbR15tZFTWveAp3adJmbln3pc8eCpPPk+ytBbRLWmEocuVUMc
         v7gm1T53tjhEjlYToRbMH8hmWrGl7FIspmaJqKNfjLZbPxA09HwXvAWdDO289i3EiA9j
         KovsJsVJCH0WO+znsOUByJh1RE/fWIeZlI3Rd41f8lbbwQbniRZbG7BvJhHX2AbDsjPS
         mYZfmSu49A5zn9Psbo8d3iRIfwxGADRB/SKl9lxJ3ynLwoitndqpQNK8WDY9vKhpjjoI
         CYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gH8Qs1XglGufegKR6TcUvOZCrGydkdLUPIUoY4Wzys0=;
        b=Z91ahUp86GOzI/glhe5iNkDzhkPkqthQr9sdf75a5Q7kLzLrmlgaEru8NZINNREDmH
         p4bxNFhAy4zC7sGiGOdWzuIVp+9eyROwvLfKJPa8ga3bJHqn0I6M5JKn7fYoylXp94Ai
         oAURkb9oqYq3FUWOaDWIjPNhIHGYHH8W7adyYdbfpkT0pIOqpVFW2tEg/dxz8YLjKo8G
         FE3A08Jm7teg5+X9aggXFceI3qKibOLGtwBpOZdl4XEP63+wPIkVztwBey54l71FJy07
         DQPBJRR/UpHeNOZZnQBHj5L2EHiJl6E+ltoq4Y4OXEWCOqMVPmv05ttg+kpting6096z
         pCcg==
X-Gm-Message-State: ALyK8tL6YQdlatrd+60UC+Q5Aq9iBqcUT0ZlgNMLdDOef850Fl9y9rmdm4oTE1RWaMgwLXQPdu1JQGNX0S6xQw==
X-Received: by 10.37.207.18 with SMTP id f18mr717170ybg.28.1464137721769; Tue,
 24 May 2016 17:55:21 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 17:55:02 -0700 (PDT)
In-Reply-To: <20160524194814.GA12479@zoidberg>
X-Google-Sender-Auth: jOO6rZmS1rmcwx1hao7WORwHOQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295548>

On Tue, May 24, 2016 at 12:48 PM, Edward Thomson
<ethomson@edwardthomson.com> wrote:
> Check that we are configured to display colors in the given context when
> the user specifies a format string of `%C(auto)`, instead of always
> displaying the default color for the given context.  This makes
> `%C(auto)` obey the `color=auto` setting and brings its behavior in line
> with the behavior of `%C(auto,<colorname>)`.
>
> This allows the user the ability to specify that color should be
> displayed for a string only when the output is a tty, and to use the
> default color for the given context without having to hardcode a
> color value.
> ---
>  pretty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks obviously the right thing to do from a cursory read.
Missing sign-off?

Thanks.
