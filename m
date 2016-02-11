From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Thu, 11 Feb 2016 16:21:22 -0500
Organization: Twitter
Message-ID: <1455225682.29013.12.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-21-git-send-email-dturner@twopensource.com>
	 <56BC4AE4.6060708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:21:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTygC-0004QB-KE
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbcBKVV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 16:21:27 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35082 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbcBKVVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:21:25 -0500
Received: by mail-qk0-f179.google.com with SMTP id o6so24374890qkc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 13:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=QsVfBLIRBLZ+B4L1YE4DVpe4OzTY/O8x4vjnhJe2cT8=;
        b=RSHiac2joad+BXO0+6zxbNRGV72/FKK/96SPpSJ1KLJ4mmdWMhqBIpc9qdmvq2Xem0
         2ouzoafcjQQYTxWhTIVvCc7qlNEZsWKpwl5AB5VZFlz8T6CtWZpV1dtmRlEt3/++5GWN
         hliYwYk8WU47Ul0MpAYz0aDt4Q6KXITmuK2bE9VDJYzLeaZBK/j0tUKltnHrRgBhdu4O
         xI7be3fCEznVYfP+RLY3KIFkrofHE8wv1kajr9zrtKOcz/72UFFVaobNKntrJxFup15U
         XlN6s8ihtM4cVnIOcKqvySBP78A2K1984li0DF5YZMFTrgb+LK9/T977OD4TfzqCUiJo
         hAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=QsVfBLIRBLZ+B4L1YE4DVpe4OzTY/O8x4vjnhJe2cT8=;
        b=BApBNh0jZcGsNJVlJUbn2IAESYQSfMgI9DvlubSnN3YS8zS9O4J/XTmf7azjwr7UHP
         w6x5xd0XGXOnVwpDiXl0+CpY4GmamsZeR7mET9iiGct/97ndoi5qI2OhZ2+IruDjignZ
         d+9dyiVNCROLszMr8hTCP+94EaximTf2ZRNCWDwjAbuAuf34ZyQiHo5iZv6pmaGujDWI
         3xcgxa7CP26euzfAd8DpbRRXnE9GTu4yLyCM5dElrmCJdAAJKQukLjXuMI1BQluSm89w
         /jTudftzbmh0KdYgL0NdSjZyujBFewDazbX9WQ5XaTOmViBl6mpWjCFFZJSL8KDN8uay
         +n1A==
X-Gm-Message-State: AG10YOQidoddq3MiBZKr7oIdfPdng9ZjRyK362V0sDiTnPX3BSYBu0ofkOnvRPpb34stjg==
X-Received: by 10.55.72.77 with SMTP id v74mr58038975qka.88.1455225684634;
        Thu, 11 Feb 2016 13:21:24 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id b6sm4172508qkh.12.2016.02.11.13.21.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 13:21:23 -0800 (PST)
In-Reply-To: <56BC4AE4.6060708@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286002>

On Thu, 2016-02-11 at 09:48 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Add a database backend for refs using LMDB.  This backend runs git
> > for-each-ref about 30% faster than the files backend with fully
> > -packed
> > refs on a repo with ~120k refs.  It's also about 4x faster than
> > using
> > fully-unpacked refs.  In addition, and perhaps more importantly, it
> > avoids case-conflict issues on OS X.
>=20
> When I compile this using gcc with -Werror=3Dpointer-arith, I get the
> following errors:
>=20
> > refs/lmdb-backend.c: In function =E2=80=98rename_reflog_ent=E2=80=99=
:
> > refs/lmdb-backend.c:1068:39: error: pointer of type =E2=80=98void *=
=E2=80=99 used
> > in arithmetic [-Werror=3Dpointer-arith]
> >   strbuf_add(&new_key_buf, key.mv_data + key.mv_size - 8, 8);
> >                                        ^
> > refs/lmdb-backend.c:1068:53: error: pointer of type =E2=80=98void *=
=E2=80=99 used
> > in arithmetic [-Werror=3Dpointer-arith]
> >   strbuf_add(&new_key_buf, key.mv_data + key.mv_size - 8, 8);

=46ixed, thanks.
