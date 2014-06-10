From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/15] use get_commit_buffer to avoid duplicate code
Date: Tue, 10 Jun 2014 04:01:29 -0400
Message-ID: <CAPig+cTztiY3va-oztwe+FRsEgtFh0r6jsYY1Vn5dtvg3fHfZA@mail.gmail.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181247.GJ20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:01:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuGzu-00047V-TM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 10:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaFJIBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 04:01:31 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34377 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaFJIBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 04:01:30 -0400
Received: by mail-yk0-f180.google.com with SMTP id 131so1784686ykp.39
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bPa6/FfP8UePyMz0sRsMjbekKNmwKNuEbHB8SzPgsqs=;
        b=cvnT0wpORqGBtAfy/TYIN0Od3RVDJcGWVoDgKRT/m7U47xy747YLG+8Ra0Z67JDcQx
         HaNZT1sd1ZIvIiU2uFsJZ+x1u1TEMsJ3gcg+3V3yCz9Vk9Qui4jLAZ9BFnZM0KNf4miY
         YYwJPJ41wMMq4Ewh0995sGkLmJO095Cw/b3sVWCzLoxrFdfz3r+kLLQKIoCntbGGxjdd
         DPN/2ZRWJ2YmijzXDd6VisBpcss/sueARY5YcSTZ5I1yZMAQ4thFLWcytV8iWLawTUFP
         zDj+WdEqX1AjIa9gdttvDCrOjI6t/EfhKf1UDK9GfgHlg7LnVg+M8WyalZNXB29sHGSU
         71zQ==
X-Received: by 10.236.88.193 with SMTP id a41mr22320517yhf.22.1402387289937;
 Tue, 10 Jun 2014 01:01:29 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 01:01:29 -0700 (PDT)
In-Reply-To: <20140609181247.GJ20315@sigill.intra.peff.net>
X-Google-Sender-Auth: tGtBt2PabeFDDJNi7hdvyloX7O0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251172>

On Monday, June 9, 2014, Jeff King <peff@peff.net> wrote:
> For both of these sites, we already do the "fallback to
> read_sha1_file" trick. But we can shorten the code by just
> using get_commit_buffer.
>
> Note that the error cases are slightly different when
> read_sha1_file fails. get_commit_buffer will die() if the
> object cannot be loaded, or is a non-commit.
>
> For get_sha1_oneline, this will almost certainly never
> happen, as we will have just called parse_object (and if it
> does, it's probably worth complaining about).
>
> For record_author_date, the new behavior is probably better;
> we notify the user of the error instead of silently ignoring
> it. And because it's used only for sorting by author-date,
> somebody examining a corrupt can fallback to the regular

Missing word here? "examining a corrupt [...] can"

> traversal order.
>
> Signed-off-by: Jeff King <peff@peff.net>
