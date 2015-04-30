From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 11:44:50 -0700
Organization: Twitter
Message-ID: <1430419490.22711.30.camel@ubuntu>
References: <20150430003750.GA4258@peff.net>
	 <1430355983.14907.55.camel@ubuntu> <20150430011612.GA7530@peff.net>
	 <1430358345.14907.62.camel@ubuntu> <20150430033725.GB12361@peff.net>
	 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	 <5541E3D4.7040207@alum.mit.edu> <1430417023.22711.8.camel@ubuntu>
	 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
	 <1430418522.22711.22.camel@ubuntu> <20150430183226.GA2855@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:45:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntSE-0006pa-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbbD3Soy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:44:54 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33707 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbbD3Sox (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:44:53 -0400
Received: by pacwv17 with SMTP id wv17so67850428pac.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 11:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CM5Zjq5nnCz9vrdT1F5tJFsrrdxzww3olLzgihgiaUQ=;
        b=DmBDtw7RgnTYOpZXrIDKNwowQaWkukmOLmx1rxpOuzqdJ7u/1C6Gx9HLYUVuw6mhRE
         yE+CisFwgxrAACMuch/98RjakXUJMMwsJx5ebg4ReX2KEaVem5bCouzJ84qlLPxek8Kd
         fQGy8+rdSL9RmU/PyjdFUjBEBDMk5L1xKJWVKSIZj5xu8SH1lLSFDKmnyospI+LWOgkL
         hS8yLaAqMi+5VlS77IWc3xLGdhZbkwLWPcePY12K/urPKg+zZ/9s5lkA0WnJtPqdjNsQ
         QzEpdwCCybDNTDgcwobekbX6ETs0Dp+qmB66Z9LCwSUQDmg67MRYGLexi/djUruJb/wt
         WyAQ==
X-Gm-Message-State: ALoCoQl9J94bJ4Wml/Cwld3c7VvaA3rirpMOzYJy9pFVS9Zt4k727V0cxiy3QNKCjyToNGB5JHEk
X-Received: by 10.70.103.45 with SMTP id ft13mr10636579pdb.149.1430419493109;
        Thu, 30 Apr 2015 11:44:53 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id fm3sm2857921pdb.28.2015.04.30.11.44.51
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 11:44:51 -0700 (PDT)
In-Reply-To: <20150430183226.GA2855@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268090>

On Thu, 2015-04-30 at 14:32 -0400, Jeff King wrote:
> On Thu, Apr 30, 2015 at 11:28:42AM -0700, David Turner wrote:
> 
> > On Thu, 2015-04-30 at 11:19 -0700, Junio C Hamano wrote:
> > > David Turner <dturner@twopensource.com> writes:
> > > 
> > > > In no case did we do a ls-files command,...
> > > 
> > > "ls-tree -r" is what I would have imagined you would be using, as
> > > somebody needs to have the full repository in order to resolve the
> > > symbolic links _anyway_, and that somebody does not need to have a
> > > checkout in order to do so.
> > 
> > Yes, they have the full repo, but we are only exploring a small fraction
> > of it. ls-tree -r would require parsing the entire thing.
> 
> git ls-tree HEAD -- BUILD ?


This does not actually seem to work (even with -r); it only recurses
into directories that are named BUILD, rather than being equivalent to
git ls-tree -r HEAD |grep /BUILD$.

Also, BUILD files are scattered throughout the tree, so the entire tree
would still need to be traversed.  At present, our monorepo is not quite
large enough for this to matter (a full ls-tree only takes me 0.6s), but
it is growing.
