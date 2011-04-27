From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: move private shopt shim for zsh to __git_
 namespace
Date: Wed, 27 Apr 2011 18:00:08 -0500
Message-ID: <20110427230008.GD18596@elie>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
 <20110427013534.GA14286@elie>
 <7v62q0b8e0.fsf@alter.siamese.dyndns.org>
 <20110427064033.GB4226@elie>
 <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
 <20110427091140.GB14849@elie>
 <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
 <BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
 <20110427212704.GB18596@elie>
 <BANLkTinKgubAeFy+mJ=hGdG8c-QXjyNTcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDif-0002V8-St
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760158Ab1D0XAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 19:00:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33451 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760197Ab1D0XAN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 19:00:13 -0400
Received: by ywj3 with SMTP id 3so788562ywj.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VkH8Jf5aqEW/fTfzpPewxG6+AZSHfqC36yyn423Gsw4=;
        b=ScIk5PIU+IhrB7JEKR8PKH5JpHo+ixxqN4hdU8RKMMByvif63yKThvFTN2DUzvHLMo
         fKC6ZzLuXbG68VRWFt7oUfwlk+4dhwOCOjAJY2JLlDxEzzjRuvHbS435jFwyIxG0Je3S
         2t2aSZ0Uanpfvm03D6Z9zMNT65hc9Qhf+rELY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NWvF+58NcBpXTVn3YqRgpJz3z0joSMjWWEfEtT1YYGX8oMZCFG1Ftb+VqWAOjUALE2
         dt9Tsrq3q/Q2VdAx9iw9MSX/g5b6vsah9+TXik1kZncdSY7qHkyplTPB/HVcMjvMQ0UG
         cB+N1WtHyTmiARvTICGYFnS1AKzrCBk78/hto=
Received: by 10.236.161.105 with SMTP id v69mr3710779yhk.83.1303945213015;
        Wed, 27 Apr 2011 16:00:13 -0700 (PDT)
Received: from elie (adsl-69-209-61-200.dsl.chcgil.sbcglobal.net [69.209.61.200])
        by mx.google.com with ESMTPS id 29sm623135yhl.34.2011.04.27.16.00.10
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 16:00:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinKgubAeFy+mJ=hGdG8c-QXjyNTcA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172287>

=46elipe Contreras wrote:

> I have been looking for a way to have local aliases or functions, but
> I can't find any.

It is possible to do

	if [[ -n ${ZSH_VERSION-} ]]; then
		alias __git_local=3D"typeset -h"
	else
		alias __git_local=3Dlocal
	fi

but let's consider that for a moment.

 1. It's ugly (it means completion code would use a dialect where the
    ordinary "local" keyword has to be spelled differently).

 2. It's ugly (use of aliases in scripts sets off alarm bells.  As
    Almquist's sh manual says:

	Aliases provide a convenient way for na=C3=AFve users to create
	shorthands for commands without having to learn how to create
	functions with arguments.  They can also be used to create
	lexically obscure code.  This use is discouraged.)

 3. It's fragile (maybe some day a function from zsh's completion
    library that we call will look at $words and get utterly confused).

I don't mean to sound so negative; actually I am very happy to see us
getting closer to a full understanding of the problem and relevant
constraints.
