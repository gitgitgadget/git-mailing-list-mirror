From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 13:42:42 -0600
Message-ID: <20110110194242.GA11801@burratino>
References: <7vhbdg6286.fsf@alter.siamese.dyndns.org>
 <4d2b5c52.68e3cdc2.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 20:43:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcNe1-0004zM-2Q
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 20:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab1AJTnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 14:43:00 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53174 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab1AJTm7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 14:42:59 -0500
Received: by vws16 with SMTP id 16so8253923vws.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8ZtXqYpbaDUnNGbe/WDuheUl8e4xD7HGaZOJfDsZhok=;
        b=gj+9Cha8gQGOSKWONkEIogrQyeC3dHqo83nAzaXr3bI26zuVd0Bm4q0Bo8ritxTcrh
         iUP/I0RiqOd4oOANTYDFqWGo64Sux+CsrNRnlg+YFUBiW+ri2uM2vsBp2pygQru1rJkF
         o4JjVvbDHipUGDceh8+Aq/R+oRl0LEWts0ibE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JI3bdbqNw0n4L1rnQFc/95Iwrmlh4hOiaKzkIO6tybSeSRPYQpxk+8U9q7+sW60f5N
         8oH7EJV7Irvov74EDlgisMb+hdxTsmB6P8NW1kaeT2ph+41zKAhY4nuc3orYGkThYi80
         v7gIo5rzEj2UuX0oij2gx7zyZm8UOlvqeptBI=
Received: by 10.220.201.194 with SMTP id fb2mr8665337vcb.199.1294688577970;
        Mon, 10 Jan 2011 11:42:57 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id fl9sm11162475vbb.0.2011.01.10.11.42.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 11:42:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d2b5c52.68e3cdc2.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164894>

Ingo Br=C3=BCckl wrote:
> As Jonathan and Junio stated,

>>  envvar=3Dvalue git command
>
>>  GIT_CONFIG=3Dother-config git config anwohner.park ausweis
>
> shouldn't affect the environment of the tests.
>
> Unfortunately, I had a shell alias function named git that interfered=
=2E In
> fact it passes to the git program (command git "$@") but sadly does n=
ot know
> about the newly set PATH and (still inexplicably to me) makes the var=
iable
> set.

=46or what it's worth, here's what POSIX[1] has to say:

	When a given simple command is required to be executed [...] the
	following expansions, assignments, and redirections shall all be
	performed from the beginning of the command text to the end:
[...]
	If no command name results, variable assignments shall affect
	the current execution environment. Otherwise, the variable
	assignments shall be exported for the execution environment of
	the command and shall not affect the current execution
	environment (except for special built-ins).=20

I am guessing the expansion of your 'git' alias starts with a special
builtin.  For the future, it is probably best to guard settings for
interactive use with

	if test "${PS1+set}"
	then
		CDPATH=3Dsomething
		alias foo=3Dbar
		alias baz=3Dqux
		...
	fi

or even better,

	case $- in
	*i*)
		CDPATH=3Dsomething
		...
	esac

Thanks for explaining.
Jonathan

[1] http://unix.org/2008edition/
