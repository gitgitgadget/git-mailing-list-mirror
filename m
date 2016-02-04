From: "Klinger, Xia" <Xia.Klinger@cognex.com>
Subject: RE: git 2.7.0 crashes when top-down memory allocation preference is
 set
Date: Thu, 4 Feb 2016 13:22:07 +0000
Message-ID: <43fbdf617f8d412db7b0d5c7d06df3ad@USNAEXCP2.pc.cognex.com>
References: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com>
 <alpine.DEB.2.20.1602040844330.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 14:22:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRJra-0005Xl-8X
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 14:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbcBDNWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 08:22:12 -0500
Received: from mx2.cognex.com ([198.232.29.14]:29080 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757615AbcBDNWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 08:22:11 -0500
Received: from galileo.cognex.com ([10.10.128.32])
  by mx2.cognex.com with ESMTP; 04 Feb 2016 08:22:07 -0500
Received: from USNAEXCP2.pc.cognex.com (alt1adc1pip [10.10.128.111])
	by galileo.cognex.com (8.14.3/8.14.3) with ESMTP id u14DM86c017457;
	Thu, 4 Feb 2016 08:22:08 -0500 (EST)
Received: from USNAEXCP2.pc.cognex.com (10.3.160.222) by
 USNAEXCP2.pc.cognex.com (10.3.160.222) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Thu, 4 Feb 2016 08:22:08 -0500
Received: from USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a]) by
 USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a%18]) with mapi id
 15.00.1044.021; Thu, 4 Feb 2016 08:22:08 -0500
Thread-Topic: git 2.7.0 crashes when top-down memory allocation preference is
 set
Thread-Index: AdFemzxLzKR7onqfTxCtkbzxea41AwAGsZHQACUAXYAAAOGvwA==
In-Reply-To: <alpine.DEB.2.20.1602040844330.2964@virtualbox>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.3.128.111]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285463>

Hi Johannes,

I am not sure the Fast Track release means. Do you refer to Windows 10 builds (updates)? I am running Windows 7 x64 and haven't gone to Windows 10.

Default memory allocation in Windows is bottom-up, which means the lowest addresses are consumed the first. This is all fine until the address is over 4GB on x64 OS with more than 4GB physical memories. Many applications don't handle it properly and will crash. Windows provides a registry key to force OS allocating memory from the highest address available first and going down the chain as a way to test application's memory management. That's what I did on my host to test our own software. And it affected Git 2.7.0.2 (latest build for Windows from 2/2/2016). 

I had to rollback to Git 1.8.4 to work around this problem. 1.8.4 is a 32-bit build not 64-bit build. That's why it worked so far.

Thanks

Xia

-----Original Message-----
From: Johannes Schindelin [mailto:Johannes.Schindelin@gmx.de] 
Sent: Thursday, February 04, 2016 2:46 AM
To: Klinger, Xia
Cc: git@vger.kernel.org
Subject: Re: git 2.7.0 crashes when top-down memory allocation preference is set

Hi,

On Wed, 3 Feb 2016, Klinger, Xia wrote:

> When the memory allocation preference is set to be Top-down on Windows 
> and there are more than 4GB memory available, git will crash. The 
> symptom is "Segmentation Fault".

This might be related to https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_git-2Dfor-2Dwindows_git_issues_627&d=CwIBAg&c=VCWpAYkS3z1bOCIxc-BPGZarCq9MRCAVxZJE051VqH8&r=67DEVp3lXDRlQoHC5xXHqK4qsTItx9yvwX98R_Hn9tg&m=jBFYZYDLdCLg-WMJPpbvl9rXn4syBv9RAGsbi106m3Y&s=MaQ04pu8kp8pdAOjVSd1PCqEwsYMpxpsFiqZ100gkrk&e= 

Do you have access to the Fast Track releases? If so, Windows 10 build
14257 was released to it and purportedly fixes these issues.

Ciao,
Johannes
