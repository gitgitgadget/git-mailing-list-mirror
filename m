From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] builtins: utilize startup_info->help where possible
Date: Tue, 19 Oct 2010 12:29:53 -0500
Message-ID: <20101019172953.GC25139@burratino>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 19:33:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8G4E-0007Pv-Aw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 19:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab0JSRdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 13:33:37 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62047 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab0JSRdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 13:33:36 -0400
Received: by pxi16 with SMTP id 16so654947pxi.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wSa4LzftA1vShgmSe0r/BoR3QaUE2eb0nyVFifqdW3s=;
        b=bdZaVh+oWOiZjCJj3zBSqkZo37otq6CtttAlYQXkbe70oQ6vXD3ZKK0Y5Ajkdhml4k
         0YnOzeRaRRUfAM6Q4QQ/ZNFRATwzlRQrNgVN8AHHuQZO1VO1VsGl3gJ3hJ0+rU6PIFAk
         xHInAj2kB1v/tDm5tco3WaK1WjU10R2J8B97Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IauHlO13ahigHD9OZqtOGCI9iYKS1Gthc7oxZEpFiVacTUlEETZWCPTacU1ogxcNV8
         gKLsMotZty1XFCgTvQ/leK6LlHydM6wa/gCmgzmI+E/++gdL29G2aiqXR9NXJQrwImPV
         YfeWwcQ4KDpmnzkBJoqNg+6pjQjSnaTF/fJwQ=
Received: by 10.229.70.132 with SMTP id d4mr940868qcj.8.1287509612587;
        Tue, 19 Oct 2010 10:33:32 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x9sm11245526qco.22.2010.10.19.10.33.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 10:33:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287495320-27278-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159341>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> It helps reduce false alarms while I'm looking for "git foo -h" code
> path that accesses repository.

Not sure I understand.  Is the idea that use of startup_info->help
is a marker for "I've checked this code path"?

If that were the only reason, I don't think I'd like the idea.

As it is, I'm a bit conflicted: what if we decide to short-circuit
"git foo --help-all" in the future just like we short-circuit
"git foo -h" now?  Would that require a separate flag?

In other words, I'm not sure startup_info->help is a good abstraction.
Maybe (modulo names) it would be better to do

struct startup_info {
	...
	const char *short_circuit;	/* "-h", "--help-all", "--no-index", or NUL=
L */
};

and use

	if (!strcmp(startup_info->short_circuit, "-h"))

to allow relaxing the argc =3D=3D 2 check later?
