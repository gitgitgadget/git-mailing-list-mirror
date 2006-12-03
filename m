X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 09:42:19 +0000
Message-ID: <200612030942.20946.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612020922.43832.andyparkins@gmail.com> <200612021255.59972.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 09:45:30 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AkiVPogW8u7yk8EkTFY9dw2fKo2/75CR26Y7Pd2Cud9OzC2EeR0KVyjaMpggvdFfvwAljSqDtphoTSuK5CgPliMg7DlUYllRDvfkdE/NRyPlwQeQIOQUvfbkRRvVoCKahCQfoiinKK/uC0sbhV+Ov8VoKoTt1zXPTPyU6WySW8s=
User-Agent: KMail/1.9.5
In-Reply-To: <200612021255.59972.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33101>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqnuV-0000TK-LI for gcvg-git@gmane.org; Sun, 03 Dec
 2006 10:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935692AbWLCJpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 04:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935736AbWLCJpJ
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 04:45:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:19163 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935692AbWLCJpH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 04:45:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2737686uga for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 01:45:06 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr10007616ugl.1165139106590; Sun, 03
 Dec 2006 01:45:06 -0800 (PST)
Received: from ?192.168.7.102? ( [82.0.29.64]) by mx.google.com with ESMTP id
 5sm26207625ugc.2006.12.03.01.45.05; Sun, 03 Dec 2006 01:45:05 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 02 11:55, Josef Weidendorfer wrote:

> > > 	100644 blob 08602f522183dc43787616f37cba9b8af4e3dade	xdiff-interface.c
> > > 	100644 blob 1346908bea31319aabeabdfd955e2ea9aab37456	xdiff-interface.h
> > > 	040000 tree 959dd5d97e665998eb26c764d3a889ae7903d9c2	xdiff
> > > 	050000 link 0215ffb08ce99e2bb59eca114a99499a4d06e704	xyzzy
> > >
> > > where that 050000 is the new magic type (I picked one out of my *ss:
> > > it's not a valid type for a file mode, so it's a godo choice, but it
> > > could be anythign that cannot conflict with a real file), which just
> > > specifies the "link" part. The SHA1 is the SHA1 of the commit, and the
> > > "xyzzy" is obviously just the name within the directory of the
> > > submodule.
> >
> > Can I argue that the hash in that object should actually be to a real
> > object in the supermodule repository rather than a link?
>
> That is the thing we already are discussing here :-)
> IMHO, submodule IDs make a lot of sense, and this needs to specify the
> submodule ID at every link. Which would force us to use seperate objects.

I wasn't really going as deep as a submodule ID.  Just moving the submodule 
commit hash from the supermodule tree, to a supermodule "link" object.  What 
goes in that object is a separate problem I believe.

The primary reason I think it's a good idea is that it is consistent with 
every other hash in the tree.  It seems to be inconsistent to say

blob objects have a hash that points to an object in this repo
tree objects have a hash that points to an object in this repo
link objects have a hash the points to an object in a different repo

> However, I am not speaking about some separation issue, but more about a
> design decision. For fetching/pulling/merging, you want be able to
> distinguish submodules not only by the commit id into the submodule:
> multiple
> submodules could link into the same DAG (but different branches) of another
> repository which would make unique fetching/pulling/merge decisions
> difficult, especially when you think about the possibility that the
> relative root path of a submodule in a supermodule should be able to change
> at any supermodule commit.

I can't say I've understood what you mean here.  There is no difference in 
facilities if there is a link object in the local repository as well.  It's 
merely an extra layer of indirection.  Apart from the tiny cost of 
dereferencing that link object, there is no disadvantage.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
