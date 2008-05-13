From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Tue, 13 May 2008 19:04:37 +0200
Message-ID: <200805131904.38317.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <200805130855.08133.jnareb@gmail.com> <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 19:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvxwt-0004mY-F8
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 19:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbYEMREu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 13:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbYEMREt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 13:04:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:56353 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbYEMREs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 13:04:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2214718fgg.17
        for <git@vger.kernel.org>; Tue, 13 May 2008 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=8ehf8b92U5WEoIob1/Oou+3w6uZ69G/FZhfTvma4sng=;
        b=P4AhaTmEnBrUvoOEe7AgrfOOEJHrbQsBnHSBCvgOaZn2/nf8lwUS89yLb8oKRPQKOU0fz++roRNAS9VzxAy05yrwejt8UVQ7a9kp0XLmYIr/NsAtR6SAF1me7tp7zbAmWYjCKZfNgNuH5fNcL1O/gh0uPkxce9xIgPr0EYYzLus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kig42oPk4e98fjh+qiUV173C/3bPvVdGaT5laURAGK5Fx+S/lwrUzrAvjgo9LlvyUqPPUvHpINro5mB3G977XkcUtonsmvIePwP4+PiUe4b1OMzFk3bfZoK4Y59IEgZO2WIvsyMI2QTMW6oYfDPUdFiAUyg/ThSEV4RoGbiw4/A=
Received: by 10.86.84.5 with SMTP id h5mr31951fgb.26.1210698286875;
        Tue, 13 May 2008 10:04:46 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.213.214])
        by mx.google.com with ESMTPS id l19sm86494fgb.9.2008.05.13.10.04.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 10:04:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580805130939m1a1ef8e0yd72402f3c79190ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82034>

On Tue, 13 May 2008, Lars Hjemli wrote:
> On Tue, May 13, 2008 at 8:55 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> But please take into account that gitweb performance, and I guess any
>> git web interface performance, is I/O bound and not CPU bound (at least
>> according to what I remember from J.H. emails).  So a little more
>> processing is I think less important than avoiding hitting the repos.
> 
> Yeah, that's a pretty convincing argument for "cache the data, not the
> output", at least for gitweb (cgit never touches the repos to generate
> the project list/search).

First, this is less argument for "cache data" against "cache output",
only against disregarding "cache data" for assumed performance reasons,
while it "cache data" can be useful in some places.


Second, gitweb's projects list page contains "Last Changed" column,
and you _*have*_ to hit repositories for this data, and backwards
compatibility prevents from removing that.

You can configure gitweb in such way that project name, owner, and
project description are read from single 'project_index' file with 
  "gitweb: Allow project description in project_index file"
patch.  repo.or.cz can do this.

On the other hand mechanism to scan directory, getting owner from
filesystem owner (plus GECOS) or repository's gitweb.owner configuration,
and project description from 'description' file in projects repository,
allow to treat gitweb in similar way to mod_userdir i.e. as service.
You don't need to register project with gitweb; you need only to create
it in appropriate place (or put symbolic link there).  kernel.org
functions this way.

I wonder how Freedesktop.org does it: it offers both gitweb and cgit
interfaces, if I remember correctly...
-- 
Jakub Narebski
Poland
