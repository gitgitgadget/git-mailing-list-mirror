From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 27 Oct 2010 11:45:08 -0500
Message-ID: <20101027164508.GB11069@burratino>
References: <20100830023812.GA4010@burratino>
 <20100830024020.GB4010@burratino>
 <AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
 <7v1v9e803a.fsf@alter.siamese.dyndns.org>
 <AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
 <20100902043500.GF29713@burratino>
 <7vvd6o14zz.fsf@alter.siamese.dyndns.org>
 <AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
 <20101027151832.GA10614@burratino>
 <AANLkTinxG-=EKeNH3--34Ya4w0E=i_bdmJ7iv2em8C+8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 18:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB97p-0004fW-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab0J0QpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:45:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39194 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0J0QpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:45:15 -0400
Received: by fxm16 with SMTP id 16so876605fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Hy6OG4jhfJzmVo5ngj4TrRPFWL6eoCtYbMHzHlR9ysg=;
        b=BFn39D4gYwdFruCLjbJ/1AciawfjEJBphuiLLMXImqbr2MPxqlkyjliBLr+zYsmT5B
         Az5HRKU8+sVxRRXkdVxzVYeTMYPiRTp7MwJAkSmkL5J1vZdSAwk0va+PXyO8LVlJf7dU
         x0EM77x2wSbqAdhtHQVJW+MB2VyzDrzjvquyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M/gcBIAJnMscTCUmxkNc6e9B4ZSdMYuJirghf07Z3IR+7KntJuc/X9E0GfVAJOuCCI
         FGIB2Qtyy6JtPeiZRq5UTiZOkLLvkB8ffF5vx/kwVZXxVnf/HRV8YzQ55+OkpvJcJ5mV
         A+WpSREcN3m16jgSdJAZUe80LUCWECvKN1zrA=
Received: by 10.223.74.198 with SMTP id v6mr1123186faj.4.1288197914160;
        Wed, 27 Oct 2010 09:45:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id u8sm4283995fah.36.2010.10.27.09.45.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 09:45:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinxG-=EKeNH3--34Ya4w0E=i_bdmJ7iv2em8C+8@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160098>

Thiago Farina wrote:
> On Wed, Oct 27, 2010 at 1:18 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I thought there was some discussion about another binary in
>> /usr/lib/git-core being a bad thing?
>
> I don't recall, why it's a bad thing?

Because those hardlinks for builtins are present for historical reasons
only.  They slow down filename lookup by some miniscule amount and tempt
authors of scripts to try the dashed form of commands.

Ah, found it.[1]

| At this point, adding the dashed-form "git-version" to the filesystem is
| going backwards.  These files are only to help people who have old scripts
| from pre 1.6.0 days with "PATH=$(git --exec-path):$PATH" with their
| environment.
| 
| We should instead try to not adding them (which would probably need tweak
| in the command list generation code in "git help"), as nobody from pre
| 1.6.0 era would have called "git-version" binary.

Hope that helps.

[1] 4a7a62f3:whats-cooking.txt
http://thread.gmane.org/gmane.comp.version-control.git/155073
