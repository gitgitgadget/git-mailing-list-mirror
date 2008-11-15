From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 10/11] gitweb: add HEAD to list of shortlog refs if detached
Date: Sun, 16 Nov 2008 00:59:39 +0100
Message-ID: <200811160059.40402.jnareb@gmail.com>
References: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com> <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 01:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1V4V-0002jy-BB
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 01:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbYKOX7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 18:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYKOX7n
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 18:59:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:22953 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbYKOX7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 18:59:43 -0500
Received: by ug-out-1314.google.com with SMTP id 39so163459ugf.37
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 15:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YEPUcJgnT/gBtZgEEqPzJP2qDLbWjgtHSVPWd33gwGQ=;
        b=ci4SHKmuWoe9nLqthpnbn5ss+RLR+cemLSgoW47JgIpDZZ0NagYUhO7y3IBrLyT2Tw
         mDnxDxrAZmuOfQMas0SS/MNty4h49T522nrPcT1Dq5yBuKXIO4nd35M4+WkN9RTp6Px5
         FqqnEe2/FIqw3bFPOxNlrwc2TbLf67dWTUXwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VT3FzKhIOU0rp0Rhmp+CMFR7eQnZH2Uv8Zz4LmkM3AqPH6lSTK1PPVNrWkk6uUMnkU
         mASc8tnngYwMaQG94JwcwGsBRpYBmdgkIhEEl3s30pcB8e5CYFnmBBfQLucK8YZOGro7
         qtNItGDO8EqzK2qMMyG4Wcmx9fGS5BvUCCaFQ=
Received: by 10.210.78.7 with SMTP id a7mr2539188ebb.156.1226793581089;
        Sat, 15 Nov 2008 15:59:41 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 5sm1662269eyf.8.2008.11.15.15.59.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 15:59:40 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101099>

On Fri, 14 Nov 2008, Giuseppe Bilotta wrote:

> Subject: [PATCH v2 10/11] gitweb: add HEAD to list of shortlog refs if detached

Errr... what?!?

It is not "list of shortlog refs", it is list of _ref markers_.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ceb0271..256c962 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2296,6 +2296,10 @@ sub git_get_last_activity {
>  sub git_get_references {
>  	my $type = shift || "";
>  	my %refs;
> +	if (git_is_head_detached()) {
> +		my $hash = git_get_head_hash($project);

+	if ($hash = git_is_head_detached()) {

if using provided (in response to previous patch) implementation, but
even that can be simplified out by using "git show-ref -h ...";
see below

> +		$refs{$hash} = [ 'HEAD' ];
> +	}

Overly complicated. The '-h'/'--head' option to git-show-ref is there
for a reason.

>  	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
>  	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
>  	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
>		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type

-		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
+		($type ? ("--", "refs/$type") : ('-h')) # use -- <pattern> if $type

>		or return;

This is I think simpler.

-- 
Jakub Narebski
Poland
