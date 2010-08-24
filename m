From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/32] cache-tree: ignore CE_REMOVE entries in
 verify_cache()
Date: Tue, 24 Aug 2010 18:15:36 -0500
Message-ID: <20100824231536.GE2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <1282688422-7738-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 01:18:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2kp-00052q-TP
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 01:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463Ab0HXXR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 19:17:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43028 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933440Ab0HXXRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 19:17:23 -0400
Received: by vws3 with SMTP id 3so12802vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 16:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3VTlF7EgvbKQSBKTVSkz2m5m4rUePbSmzE2HMWFqptQ=;
        b=rRZ9TDvqCV/CfxtJF8yCcUlatTsMmAhp35vO0bU55mAUvVP/+u43bhnFSjE6FvVJJv
         g5d2X4vHKUGPetxFqeLodObpR8o9zCpBCFkLTVGxtE60szXQchCzxpVEIPbytZVM5PcJ
         ww03h2D2Xjcy9BsCQF1OiBpYZiz+8BBch6WCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xJ5fpZW9my8gbw+edkVCt99QL+x0wgXMPjAayceAmgUF8w/4Y/z9TveN0ydVGBTCIc
         NI99I/3VFKrOzzBiySVQ/jksu8DJNHlKn1LA08efRDY/bCinEk3YDoOoexQWh0z1OcmL
         lK7zWIlXKqKlCv8dk4rMbagzDw12iB8q1Q1ig=
Received: by 10.220.126.166 with SMTP id c38mr4734053vcs.192.1282691843232;
        Tue, 24 Aug 2010 16:17:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j34sm371106vcs.4.2010.08.24.16.17.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 16:17:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282688422-7738-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154381>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **cach=
e,
>  	funny =3D 0;
>  	for (i =3D 0; i < entries; i++) {
>  		struct cache_entry *ce =3D cache[i];
> +		if (ce->ce_flags & CE_REMOVE)
> +			continue;
>  		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
>  			if (10 < ++funny) {
>  				fprintf(stderr, "...\n");

In other words, this teaches internal write-tree callers to ignore
unmerged and intent-to-add entries marked with CE_REMOVE.

Why?  When does this come up?
