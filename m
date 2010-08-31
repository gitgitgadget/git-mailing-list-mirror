From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: merging branches with separate but identical history
Date: Tue, 31 Aug 2010 16:16:02 -0500
Message-ID: <20100831211602.GF5911@burratino>
References: <AANLkTikoDkhKTRmob=B_NYJSYoby0J3Zo-Qp43AU9WfZ@mail.gmail.com>
 <AANLkTikTzZe=c=RaEYSr_wjfHht4PZihggnV9vEOehvy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Craig de Stigter <craig.destigter@koordinates.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 23:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqYDK-0005Ji-1W
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab0HaVRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 17:17:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58936 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab0HaVRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 17:17:48 -0400
Received: by vws3 with SMTP id 3so5795649vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XB1/rYPgT/gMruX3nkIqYZbRKS/Ui1KrAbTSgknF7s4=;
        b=ERoViwIO1dmAi03iaLsIuXGRZIMaDDqAIfrG1bpWxMig1dQxr8OJ4IbcIXX4NfrqEC
         Uvau0wvroLJzyNSnQ1gsFd+HALjmiBAs+LCIpCT5Oqz8PMojke0POSejQHeKihrWpDVD
         LKXloHR4D31IHRKKAjNqa6WVJBFhQ16/uFeMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vXH+bs0qjRGCHiksFqzD4o4S0TGjrCC2QXVF5JS3SS7vLukRP8sXedgSskAy2Pn9XY
         uLq7NBXbgzK1ljCp86eSJ6Y+rJkIIK8hGygP07oVrPnxwzUlfGlvCoVuhco+RwYF6pc0
         sSu5CsntkHTkyewxTdY8vvn/We1K0kui1tT0A=
Received: by 10.220.89.212 with SMTP id f20mr3692779vcm.260.1283289467222;
        Tue, 31 Aug 2010 14:17:47 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q12sm3085123vcf.11.2010.08.31.14.17.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 14:17:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikTzZe=c=RaEYSr_wjfHht4PZihggnV9vEOehvy@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154984>

Hi,

Craig de Stigter wrote:

> I have two branches which start with the same commits, and I want to =
merge them.
> I believe the two branches were individually pulled from the same SVN
> repo
[...]
> If I do:
>> git checkout branch1
>> git merge branch2
> Merge made by recursive
>=20
> The merge succeeds but the commits in each branch aren't squashed
> together (git log shows two commits for each actual commit)
> =C2=A0i.e., now my history looks like this:
>=20
> a--a--b--b--c--c--d--d--e--e--f--f--1--2--3--4--5--6
>=20
> Is there a way to do this without the duplicates? (perhaps a way to
> mark the branch as merged up to 'f', without actually performing a
> merge?)

No.  I would suggest trying

 git cat-file commit a
 git cat-file commit A

where a and A are the two versions of "a" and comparing them.
How do they differ?

If you don't care about superseding the old history and just want
to combine the two branches into a single history, you can try somethin=
g
like this:

 $ git checkout branch1
 $ git rebase -i branch1~3 --onto branch2~3
 $ git merge branch2

If the history after the fork point is not linear, you can still do
something very similar with grafts.  See git-filter-branch(1) for
details.

Hope that helps,
Jonathan
