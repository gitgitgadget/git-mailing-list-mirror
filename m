From: Jonathan Nieder <jrnieder@gmail.com>
Subject: PATH_MAX (Re: [PATCH] system_path: use a static buffer)
Date: Fri, 18 Mar 2011 06:38:18 -0500
Message-ID: <20110318113818.GA6049@elie>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de>
 <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 12:38:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Y0l-00005M-IO
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 12:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1CRLi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 07:38:27 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63633 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1CRLi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 07:38:26 -0400
Received: by yia27 with SMTP id 27so1520700yia.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6ffwcybBtvtd6Z9J1cGtr+Pn5rehUWtKsYPjp89/8Qo=;
        b=ikmNo/t5hsBbjxgwl7rOsP5s1aWMgy0PEBGNt7P5400YGksJFe+Hd9ehT3YYNPSdGk
         PZOFwIM5lEFuCORcuzboKrcHcC0/iHF9ENsTAYf82E+ZSLcU01VWSaeh4ze4pF/NvTJa
         aXcuTX1G+VbZJxcEtvTg1FEBwCPDFvpqDMdXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ah0/iLqQh4qfLJ01DJjVwsBAKUezUMo+sMQAXJDn0qc4LT2sPA/EGzjeRuueKUQSa9
         0sMvfp/ILG1l64NyTK26GWlx4wkeuj02zsX6vbOOXwUGzVJxhlRDNFj9oy+Ly9hL/d90
         a8MXcAbwqIyEmfD0mog0q84sZ2ZDxvQMQHVl0=
Received: by 10.236.77.104 with SMTP id c68mr1495754yhe.7.1300448305425;
        Fri, 18 Mar 2011 04:38:25 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id f9sm1775481yhc.4.2011.03.18.04.38.23
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 04:38:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikms3Ek1CgQHg+gT8Eqs2K6PCvOB-kWZ-aqGawg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169310>

Hi,

Nguyen Thai Ngoc Duy wrote:

> It was pointed out elsewhere [1] that PATH_MAX only specifies max
> length of a path element, not full path. I think we'd need to stay
> away from preallocated PATH_MAX-sized arrays.

No, PATH_MAX is actually the maximum length of a path, and when you
use, say, open(2), it will fail if your path is longer than that.  The
maximum length of a path component on most filesytems is 255 or 256;
PATH_MAX on Linux is 4096.

It is indeed possible to have paths with length longer than that.  The
way to support that is to use relative paths wherever possible, which
does sound to me like an interesting long-term goal (mostly because I
suspect the result would be easier to read and, especially, to reason
about with respect to race conditions).

Hope that helps,
Jonathan
