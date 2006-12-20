X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit
  hooks
Date: Wed, 20 Dec 2006 16:33:40 +0200
Message-ID: <458949C4.1020207@dawes.za.net>
References: <200612201309.02119.andyparkins@gmail.com> <45893AC6.910D5748@eudaptics.com> <200612201347.13805.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:35:56 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 2.0b1 (Windows/20061206)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612201347.13805.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34933>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2X6-0003gQ-3W for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965090AbWLTOe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWLTOe5
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:34:57 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:52467 "EHLO
 sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S965090AbWLTOe4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 09:34:56 -0500
Received: from spunkymail-a18.dreamhost.com (sd-green-bigip-81.dreamhost.com
 [208.97.132.81]) by sumo.dreamhost.com (Postfix) with ESMTP id E6C7517D936
 for <git@vger.kernel.org>; Wed, 20 Dec 2006 06:34:53 -0800 (PST)
Received: from [192.168.201.100] (dsl-146-25-74.telkomadsl.co.za
 [165.146.25.74]) by spunkymail-a18.dreamhost.com (Postfix) with ESMTP id
 C62A85B531; Wed, 20 Dec 2006 06:33:42 -0800 (PST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Wednesday 2006 December 20 13:29, Johannes Sixt wrote:
> 
>>> +       cat "$GITMODULES" |
>> useless-use-of-cat-syndrome
> 
> I tried 
> 
>  while
>  do 
>  done < file1 > file1
> 
> And that didn't work. 

It wouldn't, since the redirection overwrites the file at the same time 
as trying to read from it. A better way is to redirect to a temp file, 
and rename it if the previous operation was successful.

e.g.

0 $ echo true > t
0 $ sed 's/true/false/g' < t > t~ && mv t~ t || rm t~
0 $ cat t
false

and

0 $ echo true > t
0 $ (sed 's/true/false/g' < t > t~; false) && mv t~ t || rm t~
0 $ cat t
true
0 $ ls t~
ls: t~: No such file or directory
2 $

