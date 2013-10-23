From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Tue, 22 Oct 2013 18:34:00 -0700
Message-ID: <20131023013400.GB9464@google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
 <20131022233257.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 03:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYnLK-0007Fb-AE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 03:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324Ab3JWBeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 21:34:31 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41048 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299Ab3JWBeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 21:34:04 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so188804pdi.19
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 18:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8qhZP662C+rEfj1djhDlGEI70iwn6CQo3bbxFAjqkwQ=;
        b=kwUQ6TycZ0xFUMDYOXGOKOZD/EXLB6wYifJ2oWR7ytlaUdrMqDtz+ENjoVc/KFT2oc
         DDcAVwrxXdmo8bA2w4s9Z3u/q4TA9/aSipKH/eur0PXMH9zFLiK/9lo33E+TcGgukugP
         QiCTB9aurXJBC8WRLi/8PhdXgIC78WILv/LGqsF0gyDYcORnBJj1zxte7bEdvpDBSi2b
         C1fMrfxvqQw5as16/j1U4VqaLlYIjtieGVFiT+G/qqX8ba7wWODrvx5WYUpH9SoE0vVS
         QSdDo2UZtCCKHS6T0KLvh8Ch3v2sks4pBIq7yIlrFbV0PSoHjb9Y9QSbvHpdoF2ekU5k
         03Fw==
X-Received: by 10.66.218.166 with SMTP id ph6mr717840pac.28.1382492043826;
        Tue, 22 Oct 2013 18:34:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id py4sm667642pbb.33.2013.10.22.18.34.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 18:34:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131022233257.GA9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236496>

Jonathan Nieder wrote:

> This series seems to be instead about ensuring that authentication
> succeeds before proceding, within the same connection.

(I mean within handling of the same request, not the same connection.)

Using "Expect: 100-Continue" would also be an alternative way to
support large pushes that need to follow redirects if we didn't have
peff's "http: update base URLs when we see redirects".

Forgive my ignorance: is there a way to do something analagous to that
patch but for GSS-Negotiate authentication?  In other words, after
using the first request to figure out what authentication mechanism
the server prefers, could git prefer it in remaining requests to avoid
the need to rewind?

I don't see any simple way to do that using the libcurl API.  If
checking if the server accepts GSS-Negotiate authentication and using
that to decide whether to 'Expect: 100-Continue' is easier, that would
be fine, too.

If neither is straightforward to do, the configuration seems like a
fine workaround --- the documentation would just have to explain that
this option is meant to be set on a per-host basis in '[http "<url>"]'
sections, to true for hosts you intend to use with GSS-Negotiate auth
and false for hosts with broken 100-continue support.

Thanks,
Jonathan
