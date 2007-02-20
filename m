From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 10:21:57 +0000
Message-ID: <200702201021.58754.andyparkins@gmail.com>
References: <200702191839.05784.andyparkins@gmail.com> <200702200942.18654.andyparkins@gmail.com> <7vfy91ximy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 11:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJS8Q-0006yG-1H
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbXBTKWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 05:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbXBTKWG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:22:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:48935 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbXBTKWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:22:04 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2698277nfa
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 02:22:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jjxjXU/AQysAGIabhZu9ca55pRbMKSnoRWIVzb+y9LDJoLyH+hhrDM23K4nODRq9Q0SNnYLm5dFGGzjPG8jPnXOyfmMCOMDQSmJVmkzl7HL6zbNTL0K0nmER286OC3dmSUBgjrv7/b34mxaJluo1rhztQUjnaRNJvJ2N5FryS4o=
Received: by 10.48.217.11 with SMTP id p11mr6631603nfg.1171966923429;
        Tue, 20 Feb 2007 02:22:03 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id x24sm30042569nfb.2007.02.20.02.22.00;
        Tue, 20 Feb 2007 02:22:00 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vfy91ximy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40228>

On Tuesday 2007 February 20 09:50, Junio C Hamano wrote:

> I'd send the prefixcmp() patches first, as yours would touch the
> same lines.

Okay.

Your prefixcmp() point about them being used so regularly made me wonder if 
the following would improve readability:

static inline ref_is_head(const char *a)
{
    return (prefixcmp(a, PATH_REFS_HEADS) == 0);
}
static inline ref_is_tag(const char *a)
{
    return (prefixcmp(a, PATH_REFS_TAGS) == 0);
}
static inline ref_is_remote(const char *a)
{
    return (prefixcmp(a, PATH_REFS_REMOTES) == 0);
}

which would in turn convert:

   if (!strncmp(head, "refs/heads/", 11))
       head += 11;

into

   if (ref_is_head(head))
       head += STRLEN_PATH_REFS_HEADS;

which expresses the intent of the code far more clearly.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
