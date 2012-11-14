From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] ident: make user_ident_explicitly_given private
Date: Wed, 14 Nov 2012 08:44:57 -0800
Message-ID: <20121114164457.GA6858@elie.Belkin>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113164931.GA12626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 17:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYg5a-0004O5-RO
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 17:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113Ab2KNQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 11:45:07 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47363 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KNQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 11:45:05 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so486527pbc.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zzTjdMmYV+n2iUD9gBeGCGDTK/mYvtNLnZj4QoVMaqk=;
        b=LALa2N1CSDN/cBib7s1a4pPSGCP7AiMvZLvQjnl+QyQu90UU7VB+bYvlS/avhlUvyN
         0W9HstzFw/jtqV1yTx+jdMijsovE88UfZOMJWoQMvVzSK1aNSuSLNN/xYE+qqlFeYNix
         HLXoeDA65Xy+eANDV35tltR0C/8a293E9eoNbN/E/VVbGzg7X6EnjUGCDLTyYG79umdA
         vh192NViisrPn1FTuBWYXZT/zXRI6eJafelzDxYL8nat0vEOnPRm60Wb6aJ255/Yl075
         9LTZQTm5FD7Y4bbhjaLSCFJUA+/fpj0xY/8FhN2kzvkiFP4WN2sR0B0B0IiC0oGO67yr
         oDiA==
Received: by 10.68.203.198 with SMTP id ks6mr29453069pbc.35.1352911504787;
        Wed, 14 Nov 2012 08:45:04 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ue7sm7971336pbc.53.2012.11.14.08.45.02
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 08:45:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121113164931.GA12626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209725>

Jeff King wrote:

> There are no users of this global variable, as queriers
> go through the user_ident_sufficiently_given accessor.
> Let's make it private, which will enable further
> refactoring.
[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -1149,10 +1149,6 @@ struct config_include_data {
>  #define CONFIG_INCLUDE_INIT { 0 }
>  extern int git_config_include(const char *name, const char *value, void *data);
>  
> -#define IDENT_NAME_GIVEN 01
> -#define IDENT_MAIL_GIVEN 02
> -#define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
> -extern int user_ident_explicitly_given;
>  extern int user_ident_sufficiently_given(void);

In v1.5.6-rc0~56^2 (2008-05-04) "user_ident_explicitly_given" was
introduced as a global for communication between config, ident, and
builtin-commit.  In v1.7.0-rc0~72^2 (2010-01-07) readers switched to
using the common wrapper user_ident_sufficiently_given().  After
v1.7.11-rc1~15^2~18 (2012-05-21) the var is only written in ident.c,
and the variable can finally be made static.

This patch finally does that, which is a nice way to make cache.h
easier to read and change less often.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
