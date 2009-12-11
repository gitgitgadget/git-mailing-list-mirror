From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 02:33:18 +0100
Message-ID: <200912110233.18756.jnareb@gmail.com>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <m38wdae4k4.fsf@localhost.localdomain> <7vzl5q71rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 02:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIuMc-0003g2-MF
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 02:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762164AbZLKBb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Dec 2009 20:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762156AbZLKBb5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 20:31:57 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45023 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762155AbZLKBb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 20:31:56 -0500
Received: by fxm21 with SMTP id 21so543592fxm.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2009 17:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dsTgoJEc0HSzdCc95Trh6xHI4BHFeyhgJgy4F9jlikQ=;
        b=I9ExAWnkB0eiQID8wfq9FhbZhK0lH7c1s7zHTBOuj1auh/mXIGn7/H8QH+ZpEEuAHP
         Nc/q67onF0RwtBMGiluDW/bQHu60cvfP399oskYhRTHpJ8Tnplpm+bjjiCO+hnFgGlb/
         Dvbuh7NPXvPAlBYgdAReZEVq86k07KDONHsnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=baHq+C5r3/ECDDm1x9B/HdCQXhEt7qzsUFBfIBov2qmjn3HJamYrcJX8/dqSgGr0no
         m2SpexpupM/dxGAFs0Ag8vTVX4rqo35hqll72iYUqTT4+UCTVWzX5EqDKEAxFxsjFVk6
         4V1FLWhPTmDwcYw5+LkjHEnZGFcRQ0zHiQ1fo=
Received: by 10.103.64.19 with SMTP id r19mr276680muk.8.1260495122292;
        Thu, 10 Dec 2009 17:32:02 -0800 (PST)
Received: from ?192.168.1.13? (abvy165.neoplus.adsl.tpnet.pl [83.8.222.165])
        by mx.google.com with ESMTPS id e9sm3603532muf.23.2009.12.10.17.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 17:32:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzl5q71rp.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135065>

Dnia pi=B1tek 11. grudnia 2009 02:11, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> >   --unresolve::
> >         Restores the 'unmerged' or 'needs updating' state of a
> >         file during a merge if it was cleared by accident.
> >
> > Unless "git add foo" not only adds current contents of foo at stage=
 0,
> > but also removes higher stages from index...
>=20
> By definition, adding anything at stage #0 is to remove higher stages=
=2E

Hmmm... let's test it:

 $ git merge side-branch=20
 Auto-merging foo
 CONFLICT (content): Merge conflict in foo
 Automatic merge failed; fix conflicts and then commit the result.
 $ git ls-files --stage
 100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
 100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
 100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
 $ <edit foo>
 $ git add foo
 $ git ls-files --stage
 100644 a1b58d38ffa61e8e99b7cb95cdf540aedf2a96b3 0       foo

Now let's test '--unresolve' option of git-update-index:

 $ git update-index --unresolve foo
 $ git ls-files --stage foo
 100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
 100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo

WTF? What happened to stage 1 (ancestor)?


 $ git checkout --conflict=3Dmerge foo
 error: path 'foo' does not have all three versions

Let's recover it by hand:

 $ echo -e "100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1\tfoo" |=20
   git update-index --index-info
 $ git ls-files --stage foo
 100644 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 1       foo
 100644 3bd1f0e29744a1f32b08d5650e62e2e62afb177c 2       foo
 100644 469a41eda5c8b45503a3bfc32ad6b5decc658132 3       foo
 $ git checkout --conflict=3Dmerge foo

--=20
Jakub Narebski
Poland
