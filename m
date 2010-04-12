From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 19:02:07 +0200
Message-ID: <201004121902.08345.jnareb@gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com> <m3pr25f3ye.fsf@localhost.localdomain> <7v1vekn05h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 19:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1N1t-0004a2-8T
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 19:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab0DLRCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 13:02:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46570 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab0DLRCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 13:02:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1594671fgg.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wAkOul9Pbow3kKBElJNBPVDzq+DAVNMcK4H6NwYmox0=;
        b=ex4zwQZ2T9SvOSrjb5wl2bzpxYN4N7pCG3qyKp8j4Ma3/pQxZuHce/AEp/JYTYRw6z
         FNb68+Y4busgA98XSG++iVS7+hTWVkDaZidN4Vxp0wjzj4PKU+2N3xU9nbv4CvGD/jDp
         7AP8aNKGof+/LAK3RGZIFepgddvz5T+TuKc4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DpSoNEahcZ9qyOvr7NPPnFlhaBASSqyFyHQ+4K4DvJlm5ifIf4fRrT5puGDELwFEQj
         llLBp0LSgySlOwtAV2XlLYGiT8TsGr7+4h1bkAh6iFrqXLlI+o9WfrKLaTYpmXaykyYN
         Ea32e2P/EmfwnIPKVFuWSn5vA7e1pHhdix8D0=
Received: by 10.87.76.7 with SMTP id d7mr4053882fgl.65.1271091735884;
        Mon, 12 Apr 2010 10:02:15 -0700 (PDT)
Received: from [192.168.1.13] (abvy192.neoplus.adsl.tpnet.pl [83.8.222.192])
        by mx.google.com with ESMTPS id 26sm99356fks.22.2010.04.12.10.02.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 10:02:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v1vekn05h.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144756>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > How does special case of no value, i.e.
> >
> >    [sendemail]
> >         smtpuser
> 
> That is not a special case; that is "boolean true".

Well, it is "boolean true" *if* git-config is used with '--bool'.

If git-send-email.perl used "git config -l -z" to read all its config 
variables at once into hash, like gitweb.perl does in the 
git_parse_project_config() subroutine, it would be able to distinguish 
between those the case of no value:

    [sendemail]
         smtpuser

(in which case "exists $config{'sendemail.smptuser'}" but "not defined 
$config{'sendemail.smtpuser'}", and of empty value

    [sendemail]
         smtpuser = ""

(in which case it is "defined $config{'sendemail.smtpuser'}" but not
true "$config{'sendemail.smtpuser'}).


But as git-send-email.perl uses Git::config to read config variables
one by one (equivalent to "git config --get <variable>"), I think that
also in the case of no value you would end up with $smtp_authuser
defined but empty (and false).


P.S. I wonder if 'sendemail.<identity>' section and 'sendemail.identity'
could help with original problem...
-- 
Jakub Narebski
Poland
