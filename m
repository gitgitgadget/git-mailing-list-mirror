From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC/PATCH 0/2] Introduce safe-include config feature
Date: Fri,  3 Oct 2014 03:37:32 +0200
Message-ID: <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
Cc: Jeff King <peff@peff.net>, Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:38:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZron-00013h-IU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 03:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbaJCBh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 21:37:57 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61197 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbaJCBh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 21:37:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so222701lbg.28
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 18:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAtE38XK+faEtjvJ2SfkQz10QdU/Ir0jBPxY8/HHrBY=;
        b=c+VGTTv+Ar6w1Om6Aatzj5kwXxNo55FTVFb731egGTI+yv1l5lARTqs9gHM7+0wq9U
         CJ+D0Otdc4BJRcCB4gcblOWYaZfBe4jkp9csRH6+wcOMj9FHVCsr2lZEQfDNKBnIRyiS
         eqKETLkrC2JvdZX6Sv1jFWDvl+68aXCjHqHmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAtE38XK+faEtjvJ2SfkQz10QdU/Ir0jBPxY8/HHrBY=;
        b=T1Ln/msjNdfYEYZben/HK1z37t7viexRPU8GssHslt8nzIcFY8hDWUSRdoVurGeyrF
         S217EsumfYd07ni+ltRKioDtnkf+yapJqnD/evaeejn+EQ4nS3O+oeeZ9sHptGW93zho
         yYVqIRImLnGdRQLqwg/h3LkmQM9mB51gtNilcFoWNIM4X3+BOpQQv/CQWrJnCjvBJtAU
         1Sn5XINvdc5W1sPUUE13qk1WfwWurlIxVxO0z6JRlKzhT/j9+6DO5s1x9Giq5fFMOtZh
         CfE8u90dQwZDE/tglUth3raXrW8MmRejvj1j4+ZQVF39x2HUADg5tJkWJ9trbA9tF0nq
         Ekog==
X-Gm-Message-State: ALoCoQn0JCIm2+tsFTxpiaw0QLY8sCKmH1RT7+5rvmqRiJ21GrC/3rEu3/pphpflLXaPX3CeIFXn
X-Received: by 10.152.23.69 with SMTP id k5mr2330111laf.70.1412300274421;
        Thu, 02 Oct 2014 18:37:54 -0700 (PDT)
Received: from spencer.imf.au.dk ([130.225.20.51])
        by mx.google.com with ESMTPSA id v7sm2126751lbp.44.2014.10.02.18.37.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2014 18:37:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257827>

[trimming Ccs]

This is an attempt at implementing the suggested safe-include config
feature. It mostly has the semantics Junio suggested in the parent
post, but it does not directly extend the current include directive;
instead, it uses a separate safe-include directive. This is done so
that if a repository is used with both old and new versions of git,
the older versions will just silently ignore the safe-include, instead
of ignoring include.safe and then proceeding to processing "path =
../project.gitconfig".

Config variables are whitelisted using safe-include.whitelist; the
value is interpreted as a whitespace-separated list of, possibly
negated, patterns. Later patterns override earlier ones.

If the feature is deemed worthwhile and my approach is acceptable,
I'll go ahead and try to write some documentation. For now, there is
just a small test script.


Rasmus Villemoes (2):
  config: Add safe-include directive
  config: Add test of safe-include feature

 config.c                       | 91 +++++++++++++++++++++++++++++++++++++--
 t/t1309-config-safe-include.sh | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 3 deletions(-)
 create mode 100755 t/t1309-config-safe-include.sh

-- 
2.0.4
