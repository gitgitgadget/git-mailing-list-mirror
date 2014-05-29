From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Thu, 29 May 2014 20:41:52 +0700
Message-ID: <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com> <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 29 15:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq0bE-0003RW-1k
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 15:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbaE2NmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 09:42:24 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:40497 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505AbaE2NmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 09:42:23 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so964731qgd.32
        for <git@vger.kernel.org>; Thu, 29 May 2014 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WHk2X6+dm/EQB+utcqWHMXOCz9yp4c6kvOMXqXvKRVc=;
        b=U8Y0AFx9rd0wE/u6xiFUkOJpWk9xWXHQe3YndZhNqFoXDq52JRwRPKxxgSA6Q1gzgt
         X2NZxdtCwYhgmouYQ2DuhDJVJ2OGCUzwLhmE4TgBtGPfvr9cn6Pwvl9RbPthsNNjUbs5
         tMG2QrOdn9yfjOwRQdxQU32xxN/W12AwyIEb+kptFF9In/RS37Bcg/p5PQ4Ey4K0D7BS
         0P+SF1RCJB9PFVnZj4DHbEP8RJpl6kZ/7Lf9tUfYnVDftFLb+C6SVvOYYYL6ZOsBhNaN
         paPftgUSxxqM1D+F5sl3ZpE+zbAgKpk6Kze7CqEmPqhS+WLqNgpSFEZUFsyKHPGxrEYo
         t9pg==
X-Received: by 10.224.160.202 with SMTP id o10mr10630342qax.8.1401370943006;
 Thu, 29 May 2014 06:42:23 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 06:41:52 -0700 (PDT)
In-Reply-To: <1401320968.18134.98.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250371>

On Thu, May 29, 2014 at 6:49 AM, David Turner <dturner@twopensource.com> wrote:
>> I assume that most of the time spent in check_refname_component() is
>> while reading the packed-refs file, right?
>
> Yes.

I wonder if we can get away without SSE code by saving stat info of
the packed-refs version that we have verified. When we read pack-refs,
if stat info matches, skip check_refname_component(). Assuming that
pack-refs does not change often, of course.
-- 
Duy
