From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 31/33] refs: add LMDB refs storage backend
Date: Mon, 29 Feb 2016 20:35:38 -0500
Organization: Twitter
Message-ID: <1456796138.18017.77.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-32-git-send-email-dturner@twopensource.com>
	 <CACsJy8AUqB_1XZweTmAV4atDeUWZJhzEJoY2t9nJqp3CNcViXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 02:36:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZEF-0003KK-NN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 02:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbcCABfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 20:35:42 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33794 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcCABfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 20:35:40 -0500
Received: by mail-qg0-f42.google.com with SMTP id b67so131286587qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 17:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MsRP9AmUgsO6LO6ZzIhuul11FiLvd5Oob+dIVjLt/C0=;
        b=uESEX69ed4KGp4ZyAU/MMIDuTWOC6iInkQR9CG1aG8EI6v2UGmY9QRRkZuHM30ePqr
         gxdEW5RP06JzW5ZLbnXPQaKi/8E+F/w0I8P05Y15LYxB9vIgEb936bDeZaroZbAiYIWW
         9FWbx0QGMwgDELWMCD0qSD2UIgYPhVPuUN5P3Jij3BYJgMXwOM+CR7yjh1GdKDgXnmes
         ZVyOHm7Jv47ILWnGrF4IEWGe2ezWIWXnJrEuRl69u3LCWoa8XLpsba7rBO5hCBgaA8jZ
         1BAUF89Hbvi/2CIGO9YEBhGWn8WQb3jX+EbTE71nhqUlO4G0bSB72fWQytum86MtDZg9
         P3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MsRP9AmUgsO6LO6ZzIhuul11FiLvd5Oob+dIVjLt/C0=;
        b=bGCOEr5S5BSaBQXHURCnA8vkBwOCtmvyI1QHDTy3pXIn+EQU1jkaVGVUdDMzJgItby
         IRm7ZhEkwSegHIR651ch2LmiV5TIbAmeHXcZCppJUJ9iFFuPS45WOih32h9so3KRd1c7
         Tvtm4UyXyJUVp0dq7/4ZBsaW48L2YNToUDwLGwafgiTZjYIud4LYqJtc8RkvfgF/l35N
         Y50ftR0/dCeKR77y5qIoc2q9kbTaZcNwuOCR0QFaH/Ku5EunPrUaUAQbt3FKUr0CfNYs
         8H7dtJmUE3Tye2CH+XOdaNaCLzCw79Rs/hloXEpVMLLIc9Wlp5Vkho4wsghaXdv5H2mJ
         4KzA==
X-Gm-Message-State: AD7BkJI0hE0QrIKMbTVtAORfGCMLcOy31QnXq/3OWJujLkz4htt46LplIgV1IPW+7gPPoA==
X-Received: by 10.140.221.17 with SMTP id r17mr1502588qhb.61.1456796139962;
        Mon, 29 Feb 2016 17:35:39 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n48sm12098353qgd.38.2016.02.29.17.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 17:35:38 -0800 (PST)
In-Reply-To: <CACsJy8AUqB_1XZweTmAV4atDeUWZJhzEJoY2t9nJqp3CNcViXA@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287980>

On Tue, 2016-03-01 at 08:31 +0700, Duy Nguyen wrote:
> On Tue, Mar 1, 2016 at 7:53 AM, David Turner <
> dturner@twopensource.com> wrote:
> > +Weaknesses:
> > +-----------
> > +
> > +The reflog format is somewhat inefficient: a binary format could
> > store
> > +reflog date/time information in somewhat less space.
> 
> This raises an interesting question. What if we want to change lmdb
> format in future (e.g. to address this weakness)? Do we need some
> sort
> of versioning in lmdb database? I suppose you can always add "lmdb2"
> backend that shares most of the code with current lmdb backend. Not
> sure if that's what you had in mind though.

The weakness of versioning inside the LMDB database is that in order to
check the version, you need to already have LMDB.  That's the argument
for "lmdb2". 

I had sort of hoped that this version would be "good enough" that we
could avoid modifying it.  So maybe that means we ought to address the
reflog format.  But I'm not sure that it's that big a deal.  What do
you think?
