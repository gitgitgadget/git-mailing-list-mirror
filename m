From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Mac OS 9 (Lamp) port
Date: Sun, 30 May 2010 22:19:06 -0500
Message-ID: <20100531031906.GA465@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
 <20100527101043.GA4390@progeny.tock>
 <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
 <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
 <20100530003718.GA27024@progeny.tock>
 <67A778DE-DB7E-40A3-9BE8-4D17F09B847F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 31 05:19:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIvX9-00057A-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 05:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab0EaDS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 23:18:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39213 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab0EaDSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 23:18:25 -0400
Received: by gwaa12 with SMTP id a12so2381677gwa.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 20:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wbntHQAwiY0SGOL1f/8Do6r+oLsrWHvySpiqLgK3dkw=;
        b=l1FzCAqp6K2reb/ktLeSE5xsoTZ/SpQc3q4QVG54dbOuKmNqsUi+RMIspVuvcsoUK0
         /TrWxAGAbWn27OWN1OiktB/gEnujaCje432n6T32pGPwLDfWfNvr5kXlqYkUEgsdvSvj
         28DLKSermOI7qhPohWGNO1ZgDuNQo67rMVy9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=O6+zzYQUQ0LNUmyZ2O+P9/a+hl+aGmxxD6yqSYpO+kLlt9/qJ9Trpv1pzvRqJxRb0P
         L3egV7Aswue0ES64eGVugeio1shhyTMdPkXozYoWCf0TMkuIHuDv360m3OKgbIwiFdk0
         13PQziC8FTq3cyUZraelRbOF/cubrsxBkJ6cU=
Received: by 10.231.120.19 with SMTP id b19mr4965161ibr.82.1275275904766;
        Sun, 30 May 2010 20:18:24 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm24112694ibg.15.2010.05.30.20.18.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 20:18:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <67A778DE-DB7E-40A3-9BE8-4D17F09B847F@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148031>

[new thread, cleared cc list]

Hi Josh,

Joshua Juran wrote:

> http://github.com/jjuran/git.git

I assume the lamp-git branch is the interesting one.  Some of
these patches (e.g., a3b378781) look like they might be of general
interest, while others (e.g., 6e6b106d) reveal Metrowerks to be
a bit braindead.

Have you thought about getting git to compile in C++ mode, where
Metrowerks might be a little more sane[1]?  Sure, this runs into
basically all the major incompatibilities between C and C++[2], but
that might not be insurmountable:

 . No implicit conversion from void* to other: don=E2=80=99t use void *=
,
   then.  With type-safe interfaces like

#define typed_malloc(size, type) (type *)xmalloc(size)
#define malloc_many(nmemb, type) typed_malloc((nmemb) * sizeof(type), t=
ype)

   one can take advantage of type checking without the annoyance of
   casts at the call site.

   Another place git uses void * is for low-level access to the
   object database, because it is not obvious whether objects data
   should use char * or unsigned char *.  unsigned char * should
   be fine.

 . Use of C++ keywords:

#ifdef __cplusplus
#define template git_template
#define typename git_typename
#endif

   It is not like this is an actual C++ program.

 . Assignment of ints to enums is forbidden: okay, this one is
   not worth working around.  Does Metrowerks have an option to turn
   off this piece of C++ insanity?

Curious,
Jonathan

[1] e.g., to solve the problem you described before:
http://thread.gmane.org/gmane.comp.version-control.git/115301

[2] http://www2.research.att.com/~bs/bs_faq.html#merge
