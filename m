From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add the GIT_SENTINEL macro
Date: Thu, 18 Jul 2013 20:36:34 -0700
Message-ID: <20130719033634.GB27853@google.com>
References: <51E849C4.7020305@ramsay1.demon.co.uk>
 <7vr4evz0oc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 05:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V01Uq-0007d5-DM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 05:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933502Ab3GSDgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 23:36:40 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58325 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab3GSDgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 23:36:39 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so3918644pbc.29
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 20:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C5MiVF1GRkoNwIkk2E+E0Lh49GMgM4Xokv9aWdvHO6U=;
        b=wbdAvo9RGw9I4W5ALWXdp0PupXt+oCoeo6dqwCKVbzQ3ycc4d3vvmKF5e27z0y0QZj
         yE5f5Vw49m1xEbVxxea1kdFsitrQB1khRtvWaVu5CMYSGLkOv3Wt0q4AX1pWtS6qOnt4
         fWxeMNs/UBAKO9jlVPYYMr3cVBwNK2Tij/vbQeqtDpLln6U4bDzUPsco3sMpfWp7f41h
         PUEET0I7iMd8N62ZP5oyDfVcDq/HHEh0T8XgIGeqDZnHxmgAv9QhQ2iPgYm9rY6D038k
         Euff6vV+IedZxwqThgaAL/tMYqdL/Avn0LJVYS5slOAX2sdohSpDs27lcwedRO/1naTx
         H6Nw==
X-Received: by 10.66.189.225 with SMTP id gl1mr16309856pac.22.1374204999187;
        Thu, 18 Jul 2013 20:36:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg3sm16871853pbc.24.2013.07.18.20.36.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 20:36:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr4evz0oc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230778>

Junio C Hamano wrote:

> It seems to apply well on the tip of jk/gcc-function-attributes.
>
>  - This macro is not about "git" at all, so I'll edit the patch to
>    call it GCC_ATTR_SENTINEL before applying.

Would naming it something like LAST_ARG_MUST_BE_NULL instead make
sense?  That way, if some other compiler gains a different syntax for
the same annotation, it would be possible to do

	#if defined(__GNUC__) && __GNUC__ >= 4
	# define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
	#elif defined(_MSC_VER) && _MSC_VER > 27
	# define LAST_ARG_MUST_BE_NULL __declspec(lastargnull)
	#else
	# define LAST_ARG_MUST_BE_NULL
	#endif
