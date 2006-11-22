X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Adding glob support to remotes
Date: Wed, 22 Nov 2006 14:41:00 +0000
Message-ID: <200611221441.02459.andyparkins@gmail.com>
References: <200611220904.21850.andyparkins@gmail.com> <7v7ixnskql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 14:41:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j39JGD2FdLJK9GN066EPJx4tehPEqt469na1Og+SWTSbtieEAy5Lg7i9WxIUnqa6WHsSjQgeB9N6+JdPssTc7OBtP5GKZQA1IQzAbIlyRZtA6PaPlegyEQebqG+UxclrrOSKSrXNetEe9mq5d2SGToAc8WWrubdy1r8+626xF+g=
User-Agent: KMail/1.9.5
In-Reply-To: <7v7ixnskql.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32088>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmtHn-0005Gt-CN for gcvg-git@gmane.org; Wed, 22 Nov
 2006 15:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752694AbWKVOlL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 09:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbWKVOlL
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 09:41:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:13939 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752694AbWKVOlJ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 09:41:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so182405uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 06:41:08 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr3163417ugg.1164206468131; Wed, 22
 Nov 2006 06:41:08 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id k1sm11710835ugf.2006.11.22.06.41.07; Wed, 22 Nov 2006 06:41:07 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 22 12:56, Junio C Hamano wrote:

> > However, git-ls-remote needs the name of the remote repository (of
> > course), but that isn't directly available in git-parse-remote.sh.
>
> Is it really the case?  I do not remember the details offhand,
> but I do not think canon_refs_list_for_fetch is the function you
> should be messing with to implement the remote."origin".fetch
> stuff.  It should be get_remote_default_refs_for_fetch().  The
> function returns the list based on which remote, so it surely
> knows which remote the caller is talking about.

The problem is that canon_refs_list_for_fetch bombs out too early because "*" 
is not an acceptable name for a ref.

> However, I would recommend against actually running ls-remote to
> help "git-fetch" inside git-parse-remote.sh.  I think you should
> run ls-remote upfront early in git-fetch because there are at
> least two other parts in git-fetch that wants the same ls-remote
> output:

Okay.  That's what I'll do.  It means altering git-check-ref-format to prevent 
the early bomb out.  Perhaps I should move this check to somewhere after I've 
done the reflist expansion?

>  (1) dumb protocols currently cannot deal with a remote that has

I'm not sure I've understood this point.  I shall look at git-fetch.sh more 
closely to try and address this though.

>  (2) when doing a fetch with tracking branches (which is what

Accepted.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
