From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] clone: tighten "local paths with colons" check a bit
Date: Fri, 27 Sep 2013 14:56:31 -0700
Message-ID: <20130927215631.GN9464@google.com>
References: <1380289693-593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Morten Stenshorne <mstensho@opera.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 23:56:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPg1g-0002pY-0m
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 23:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3I0V4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 17:56:37 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:41807 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab3I0V4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 17:56:35 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so3068914pbb.38
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IWmjnoMm1d59ZbNORqDSFEl1kzUV4IXvzt5CjHRwKoM=;
        b=f1XplOU8DBFM2HirSD71V02bMNZJan32lXgcOy4G5qvJk6lfokZKk7LLYUtfnMgMIA
         DEOMkOmUTxQuIcNBnCzCFcMPLfbwqu2R77cPMutdpTMRH4QER5HLmAR5mbwGo2fov5FE
         2FSN4z2dzuyHcpTqDeVtRVWZGpHk6GhSD5edANb/oYtxc4td8caO3N48aevpty6Lco6T
         +yd3lzl7dZTqGOMdaqruGEjCcO3flJx+CiTCcPKxJopKuxAD1lA1YpNmlN6HGcwGAVq/
         DQmpxb+nuJFubV4QkXCm8sQnNm/FH7YRIUcskTOFkbCXuhciIzPNkOI3zu2D1FOyVw9A
         +mwQ==
X-Received: by 10.68.192.195 with SMTP id hi3mr9923844pbc.18.1380318995187;
        Fri, 27 Sep 2013 14:56:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id go4sm10924689pbb.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 14:56:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380289693-593-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235476>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> commit 6000334 (clone: allow cloning local paths with colons in them =
-
> 2013-05-04) is added to make it possible to specify a path that has
> colons in it without file://, e.g. ../foo:bar/somewhere. But the chec=
k
> is a bit loose.
[...]
> Make sure we only check so when no protocol is specified and the url
> is not started with '['.

More precisely, this disables the "'/' before ':'" check when the
url has been mangled by '[]' unwrapping (which only happens if the
URL starts with '[' and contains an ']' at some point later).

If I try to clone "[foo]bar/baz:qux", after this change it will act as
though I specified the remote repository "foo:qux" instead of the local
repository "./foo:qux" as before this change.  Both are wrong ---
that's a bug for another day.

Thanks, both.
