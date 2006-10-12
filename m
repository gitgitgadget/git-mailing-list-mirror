From: apodtele <apodtele@gmail.com>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Thu, 12 Oct 2006 11:04:35 -0400
Message-ID: <d620685f0610120804l59c38e07uf7b624b2a0026aea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 12 17:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY26x-00015L-Sg
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 17:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWJLPEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 11:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWJLPEg
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 11:04:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:33137 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932571AbWJLPEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 11:04:36 -0400
Received: by wx-out-0506.google.com with SMTP id s14so575297wxc
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 08:04:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b245EMJZ66fw31ExbKVsSYd67a+sNnY34XmOBCHnDmfKqpqkVTE8JzoBM8PfZwFAENY68IZ7efgRdtGHfGwIjNkajdiJqedGr/jTzP5c0ZvOiM/qoxqtvdSB9zvwHjp1HGOpkeFzP3R5OfK0/zkFojTliBxdna8e/p0+9dFVtis=
Received: by 10.90.49.19 with SMTP id w19mr1341856agw;
        Thu, 12 Oct 2006 08:04:35 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Thu, 12 Oct 2006 08:04:35 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28784>

Sublinear solution without patch is below.

On Sept 28, 2006 Martin Waitz wrote:
> On Wed, Sep 27, 2006 at 08:12:49AM -0700, Linus Torvalds wrote:
>> No _way_ is it correct to show more than three characters if there were
>> three lines of changes.
>>
>> I think "nonlinear" is fine, but this is something that is "superlinear"
>> in small changes, and then sublinear in bigger ones (and then apparently
>> totally wrong for one-line changes).
>>
>> It should at least never be superlinear, I believe.
>
> So if we want to keep the logarithmic scale we can do some maths:
> Assume we use a formula ala
>         length = a log(change + b) + c

You are probably looking for much simpler, log-less, and pure integer:

        length = width * change / (width + change) + 1

Assuming target witdth of 40, for example, it will produce

Change    Length
1         1
2         2
3         3
4         4
10        9
20        14
30        18
50        23
100       29
1000      39
10000     40
1000000   40

--
Alexei
