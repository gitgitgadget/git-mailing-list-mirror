From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] add strnncmp() function
Date: Mon, 16 Jun 2014 13:16:44 -0700
Message-ID: <20140616201644.GN8557@google.com>
References: <cover.1402945507.git.jmmahler@gmail.com>
 <58e0ac866bdeb8cc6e06cf553a459af351ccfd1b.1402945507.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:16:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwdKm-0006hg-4E
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 22:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbaFPUQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 16:16:48 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61769 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbaFPUQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 16:16:47 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so4873868pac.39
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NXzuUbaLl4WqlW/5t4lEhPSPhQpU4TfuOMtN6VubNt8=;
        b=Z6VoCFOxPxn1KGX4qBtkgfOztcn+QmhU0pD8sjucXJPKkVDwZGOkq20Sy0F//qGKR2
         03D1hNxUY+OP6idjeZe60rZxjebnXlBpC5Fim/1LGI3Uo20DUtLEHc0btAGpmQ9EU2lO
         Q9E+LYCrxyIrpmKkoUFhhA7TaCAez61zR+Yf+sj4uuAtuBQLvBcA5wHPkG3iIMERvPeg
         SOIzPHbq2ic+Rzjh/KoJx2/iNwcrSqq7nj4nga3hCZM4Hszt7sVLM/8mA352XR6OtRSx
         h8HpkV9iozaoSLCKUUmA1BrVw+MVl14lnXD+tJcjfCK5dXdaSSJk/OA5oE2ejy0gdh2J
         ZDuw==
X-Received: by 10.66.132.70 with SMTP id os6mr26586655pab.110.1402949807409;
        Mon, 16 Jun 2014 13:16:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id or4sm20303547pbb.17.2014.06.16.13.16.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 13:16:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <58e0ac866bdeb8cc6e06cf553a459af351ccfd1b.1402945507.git.jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251816>

Jeremiah Mahler wrote:

> Add a strnncmp() function which behaves like strncmp() except it uses
> the length of both strings instead of just one.

The above description isn't very clear to me.  Problems:

 - strncmp compares prefixes of \0-terminated strings.  This function
   compares two binary buffers which can contain \0

 - strncmp is a comparison function and can even be used with functions
   like qsort (for operations like "sort on the first two characters").
   This function returns 0 or nonzero.

Would something like

  /* true if buffers have the same length and are byte-for-byte identical */
  int bufeq(const char *, int, const char *, int);

(or buf_equal, array_equal etc) make sense?
