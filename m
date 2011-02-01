From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tracking empty directories
Date: Tue, 1 Feb 2011 12:35:08 -0600
Message-ID: <20110201183508.GE3771@burratino>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino>
 <201102011451.17456.jnareb@gmail.com>
 <20110201172835.GA3771@burratino>
 <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkL4W-0008TO-G6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1BASfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 13:35:17 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52883 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab1BASfQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 13:35:16 -0500
Received: by qwa26 with SMTP id 26so6999461qwa.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 10:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=2m4rxz3buR6RCAG3gVGizF1oNT3nTg59DOEp7Ftr8cU=;
        b=rH2VQYshurIzrVJUdVduPcLsp3jqoXmYJ3XHIk3drzwCw9NjfbnMNezfS5QY17z1GS
         kogpVXUflBg/hW/rOQUjhVerguPaXxrIoIan959biEHBqflTAjycCr5KKSOZ0OQjSqNS
         sTWWL1jEp1pCVEyvXt69jgIfOUxfDMoradwII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=joafJn8nPdDiXwlIK+WcEXQcoWITO5xfJ+2qNv5ZLHRnUL9e0xOjPGupJ0Hw1sU/t1
         6XgLnDvEJgWfsyFgRoaTzN20gjTx6m1pPhiSgRzjkHzwtS0pFfbRKUIen43JMH757aJK
         3Utxy0lWuVRMVsfTcnQpsJbtFt7cnMykJAhDo=
Received: by 10.229.85.207 with SMTP id p15mr7288027qcl.167.1296585315601;
        Tue, 01 Feb 2011 10:35:15 -0800 (PST)
Received: from burratino ([69.209.75.28])
        by mx.google.com with ESMTPS id y17sm15832516qci.33.2011.02.01.10.35.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 10:35:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165842>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 2, 2011 at 12:28 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> I have ideas about how to resolve those tricky corner cases, but not
>> about what the UI should look like. =C2=A0How does one go about addi=
ng a
>> directory? =C2=A0Does it ever get implicitly removed?
>
> I suppose a special command for it is appropriate (git-keepdir?). Man=
y
> index-related commands are recursive by default and hard to change.
>
> Yes I think it should be automatically removed from index when a file
> is added inside tracked directories. Removing those files will also
> remove the containing directory though.

Okay, I'm convinced.  This fits a "worse is better" point of view
nicely.

To add, one would use "git update-index --add".  The magic disappears
when you register a file within that directory; to tell git you want
to keep it, one would mkdir and "git update-index --add" again.  Once
it's working, we can think about if there is a need for making that
last step automatic after all (my guess: "no"). ;-)

Use case: [1]
Nice starting point: [2]
Motivational word of wisdom: [3]

This treatment leaves out the backward compatibility detail.  I still
think that's the easy part (at worst, we can always implement read
support, wait a year, and then turn on write support).

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/46947/focus=3D=
47278
[2] http://thread.gmane.org/gmane.comp.version-control.git/52813/focus=3D=
52908
[3] http://thread.gmane.org/gmane.comp.version-control.git/53494
