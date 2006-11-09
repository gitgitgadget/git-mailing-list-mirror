X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 10:24:34 +0100
Message-ID: <200611091024.35019.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net> <200611090104.32247.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 09:24:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PiCxnjePZIEsgvDItdlwhan1Nf1xuPHU17XL45lhU+6if8afTIcnteD4ExtD91M1XpJy+TbwgsWiFwYWUIKa5GczIPgiTcS2jMcxNoBkvPIfOPwF2L+3C+ai3ORkbU+yQDlsE1OwkF0pKHariUaSCQJrFey9nyTaQxmXs/dsxOQ=
User-Agent: KMail/1.9.3
In-Reply-To: <200611090104.32247.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31184>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi68U-00018v-EG for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754800AbWKIJXr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 04:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbWKIJXr
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:23:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:52012 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754800AbWKIJXq
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:23:46 -0500
Received: by ug-out-1314.google.com with SMTP id m3so161321ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 01:23:44 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr1003883ugi.1163064224684; Thu, 09
 Nov 2006 01:23:44 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id u6sm572522uge.2006.11.09.01.23.43; Thu, 09 Nov
 2006 01:23:44 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> I'm not sure what quoting to choose for esc_attr, but there we could
> use even --no-control-chars quoting (replacing any control character
> by '?');  but perhaps in some cases like git_print_page_path
> subroutine CEC is better.

I'm rambling. esc_attr is special case, because CGI does escapeHTML
(and I hope also to_utf8) for us. Using <span class="cntrl">...</span>
has also no sense. So there should be separate esc_attr_path subroutine
I think.

Even if we decide that esc_html and esc_path should give identical
output (the difference that _might_ be here is that in esc_html we
don't need to escape whitespace control characters valid in HTML,
like tab (HT, TAB) or newline (LF); on the other hand thanks to
line-by-line processing we should never get newline in "blob", and
thanks to untabify we should never get tab in "blob") I think it would
be prudent to have esc_path, even as thin wrapper just caling esc_html.

We might decide to use different style for control characters in
different views, but that I think can be done using pure CSS.
-- 
Jakub Narebski
