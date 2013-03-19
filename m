From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] make pathless 'add [-u|-A]' warning less noisy
Date: Mon, 18 Mar 2013 20:44:15 -0700
Message-ID: <20130319034415.GI5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 04:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHnTk-00019J-S8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 04:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3CSDoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 23:44:21 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:58252 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3CSDoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 23:44:20 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so39091pbc.28
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 20:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uCnKykscwdD8KLmnVuOCRpiwSsWoizflRQCEFuKie0M=;
        b=YCE4MG0vi4aNMv4el5bFSsYuFe770l/Pc19nLHwjupYPuo4aN2bOxH+Ni2So4fg1fj
         Af0ybbv+Apau+L7k8niuRPVRfJcT9DVVK2A7EsCRcBwzIiNYWEmBCTR5ltY1gGp7DfpW
         VyaJtLa3PpU8GNne5fk4qkLhStaQblYSVvemtkcmsZaSOB+nldg5anJ7tKc4godvQvL2
         zeKfiXrapbmHYcJr8+JuS5eLRtgMRuSc5xz877Q7/UJmS+8XspB1qlkesRQdUdMW8Frr
         9POvqsy1GkW57QbWw0hBPCVoIITrUFDKk0JK/boEm6b8usCF5t4k9vEDZkwZMsk68tjY
         611Q==
X-Received: by 10.66.164.4 with SMTP id ym4mr992542pab.92.1363664660480;
        Mon, 18 Mar 2013 20:44:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id rl3sm22481993pbb.28.2013.03.18.20.44.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 20:44:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130313041037.GB5378@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218473>

Hi,

Jeff King wrote:

>                                                          The
> config option added by this patch gives them such an option.

I suspect the need for this config option is a sign that the warning
is too eager.  After all, the whole idea of the change being safe is
that it shouldn't make a difference the way people usually use git,
no?

In other words, how about the following patches?  With them applied,
hopefully no one would mind even if the warning becomes a fatal error.

Looking forward to your thoughts,

Jonathan Nieder (4):
  add: make pathless 'add [-u|-A]' warning a file-global function
  add: make warn_pathless_add() a no-op after first call
  add -u: only show pathless 'add -u' warning when changes exist outside cwd
  add -A: only show pathless 'add -A' warning when changes exist outside cwd

 builtin/add.c | 142 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 99 insertions(+), 43 deletions(-)
