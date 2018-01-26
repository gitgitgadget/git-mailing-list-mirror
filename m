Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91431F404
	for <e@80x24.org>; Fri, 26 Jan 2018 01:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeAZB4T convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 25 Jan 2018 20:56:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:56244 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbeAZB4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 20:56:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([68.71.24.102])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w0Q1uFBS089060
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 25 Jan 2018 20:56:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Basin Ilya'" <basinilya@gmail.com>, <git@vger.kernel.org>
References: <e9518459-ebcd-d415-474f-8504472b7a1d@gmail.com> <001101d395e8$31d94430$958bcc90$@nexbridge.com> <79fd9c0b-3067-afce-1fcd-507b7c97889e@gmail.com>
In-Reply-To: <79fd9c0b-3067-afce-1fcd-507b7c97889e@gmail.com>
Subject: RE: pushing a delete-only commit consumes too much traffic
Date:   Thu, 25 Jan 2018 20:56:09 -0500
Message-ID: <000f01d39648$d918f6e0$8b4ae4a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI6yB04ulyuwbhKBQwXrx3kFgdBlwI+kYsAAjmSgMaikz410A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So the point here is that the jars are still in the repository. They are deleted in your branch, but any objects depending on others (without a lot more information on your exact repository structure) may cause packed objects to be sent upstream. The delete is local to your branch, but the delete does not mean the objects are actually removed from your repository. To actually effect a removal, the objects would need to be no longer accessible, thus git gc would remove them permanently. That may be difficult depending on security on your upstream repository and what you are able to do there. So:

A--- B--- C

If A has no jars, B has the jars and has A as its parent, and C has no jars, but has B as its parent, then B is still accessible and the jars still exist in the repository but only not at the HEAD of your branch. Your tree may vary. How a push gets objects from your repository to your upstream depends on more information that I have but the point is that the jars still exist in a distributed sense. Your repository state and the upstream repository state do not need to be (and are likely not) identical.

> -----Original Message-----
> From: Basin Ilya [mailto:basinilya@gmail.com]
> Sent: January 25, 2018 10:08 AM
> To: Randall S. Becker <rsbecker@nexbridge.com>; git@vger.kernel.org
> Subject: Re: pushing a delete-only commit consumes too much traffic
> 
> > Were the 60Mb of jars previously pushed in a commit that already existed
> on the upstream?
> yes
> 
> > Was the delete an actual removal of history or did you commit with the jars
> deleted, then pushed?
> I committed with the jars deleted
> 
> > Did you do a merge squash or delete branch to effect the removal.
> No
> 
> 
> 
> 
> On 25.01.2018 17:24, Randall S. Becker wrote:
> > On January 25, 2018 9:15 AM, Basin Ilya wrote:
> >
> >> I had a 60Mb worth of unneeded jar files in the project. I created a
> >> new branch and performed `git rm` on them. Now while I was pushing
> >> the change the counter of sent data reached 80Mb. Why is that?
> >
> > Can you provide more info? Were the 60Mb of jars previously pushed in a
> commit that already existed on the upstream? Was the delete an actual
> removal of history or did you commit with the jars deleted, then pushed? Did
> you do a merge squash or delete branch to effect the removal. More info
> please.
> >
> > Cheers,
> > Randall
> >
> > -- Brief whoami:
> >   NonStop developer since approximately NonStop(211288444200000000)
> >   UNIX developer since approximately 421664400
> > -- In my real life, I talk too much.
> >
> >
> >

