From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 2/3] gitweb: add patches view
Date: Tue, 16 Dec 2008 11:16:44 +0100
Message-ID: <200812161116.45024.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <200812160414.56486.jnareb@gmail.com> <cb7bb73a0812160149j1dcaefccv1caf4a2e589ffebb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 11:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCX0G-0003iY-2k
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 11:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbYLPKQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 05:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYLPKQv
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 05:16:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:33574 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYLPKQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 05:16:50 -0500
Received: by nf-out-0910.google.com with SMTP id d3so522045nfc.21
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=L+qrEVdb7Puxh73woJZ1pzTPIXZr8YuyLYV5lECLSuM=;
        b=BCobDF5E3hspkgHujUoOtog8fOF1xjVoRk2fJzc7Q4pPxC9KzHrIaLg3pdu7jkXfav
         v75gubzWy3ZSelfBwBFc5Id6LWKriwqlY9IKjsH7pxZ/Jhv5mWn2HjKIoS1tfspi8XZp
         DPuDKOuKMzd4kTyuhKwsyyWkV8ZPK3EL7mV0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K+y0yrlXLrJJ52/N5UbzA+AQiAhuBwymlHmkNcIBMC2i9+yMHbifCKIheu2awjcPLi
         CP3Zuz3l0DuqbRGdzF0e+pdcGyaqzSUIKAHBL0APdjlQqC5o+WS9LpkoqEmq5samjqrf
         MmTBWu+6kvVCGQ5I0xCLuvFRH5iosK3zuiTNo=
Received: by 10.210.61.11 with SMTP id j11mr9016544eba.104.1229422608898;
        Tue, 16 Dec 2008 02:16:48 -0800 (PST)
Received: from ?192.168.1.11? (abve222.neoplus.adsl.tpnet.pl [83.8.202.222])
        by mx.google.com with ESMTPS id 3sm1267535eyj.55.2008.12.16.02.16.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 02:16:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812160149j1dcaefccv1caf4a2e589ffebb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103269>

Giuseppe Bilotta wrote:
> On Tue, Dec 16, 2008 at 4:14 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sat, 6 Dec 2008 16:02, Giuseppe Bilotta wrote:
>>
>>> The only difference between patch and patches view is in the treatement
>>> of single commits: the former only displays a single patch, whereas the
>>> latter displays a patchset leading to the specified commit.
>>
>> I like that fact that we have "patches" action which intent is to
>> show series of patches, and "patch" action which intent is to show
>> single patch. I'm just not sure if "patch" view should not simply
>> ignore $hash_parent...
> 
> I had doubts on this myself. In the end I decided to make patch
> consider hash_parent if present because IMO it's what a user would
> expect in case e.g. of hand-crafted URLs.

Ah. I can understand that.

[...]
>>>  sub git_commitdiff {
>>>       my $format = shift || 'html';
>>> +     # for patch view: should we limit ourselves to a single patch
>>> +     # if only a single commit is passed?
>>> +     my $single_patch = shift && 1;
>>
>> What does this "shift && 1" does? Equivalent of "!!shift"?
>> Is it really needed?
>>
>> Perhaps it would be better to use %opts trick, like for some other
>> gitweb subroutines (-single=>1, or -single_patch=>1, or -nmax=>1)?
>> Or perhaps not...
> 
> It would be MUCH better, I'll do it this way. I'll pass the -single
> param in both cases, having value true/false, even though the false
> case is not needed since undef is false in perl anyway. (I like
> symmetry.)

-- 
Jakub Narebski
Poland
