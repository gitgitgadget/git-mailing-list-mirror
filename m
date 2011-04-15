From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Fri, 15 Apr 2011 19:43:10 +0200
Message-ID: <201104151943.11537.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com> <1302878645-458-11-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 19:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAnAM-0000D1-8d
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab1DORul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 13:50:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63866 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab1DORul (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:50:41 -0400
Received: by fxm17 with SMTP id 17so1961612fxm.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=DDg1nElVDFiXQNCgHTKG+Jddzsgu+wUtqm0uOLG29CU=;
        b=V6ku1iQn08qD+ERe+HZYhrg+6FHzhSL9n/8kTJ8oEbcWjeTfbEbKXUbfF5U+MKlylI
         4oIQc5CQvWa4hDmvNwWNhuH5A3x+yAderKuA4CSqwtf7xiDQuo5mE1Osbl9NLeDVcxh1
         QYDVYbiyZOJa/WZPrSXri2JyKpJIE5IYFY6gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=i6Kl4yREYxeU3pXFTw6SVV1I4XvHHoyDxEIaLFUxTU/Pr2aH+Zu+GhE0lPscCzLivo
         zqpozeUfTwGO0F4maEV7FzL26ex9UJ/iLUFtlg+REbm89LW6x+w8z4K/Dlli/ufZgWBL
         CJsI7b/5idR91Ftt18lUDBWKfUrF21l2L1YXA=
Received: by 10.223.15.141 with SMTP id k13mr872207faa.30.1302889399966;
        Fri, 15 Apr 2011 10:43:19 -0700 (PDT)
Received: from [192.168.1.13] (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id n2sm860609fam.4.2011.04.15.10.43.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 10:43:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1302878645-458-11-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171623>

On Fri, 15 Apr 2011, Jakub Narebski wrote:

> KNOWN BUGS:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Timezone selection doesn't work in Chromium 6.0.472.62 (59676) and
> =A0 Google Chrome 10.0.648.204:
>=20
> =A0 Uncaught Error: NOT_FOUND_ERR: DOM Exception 8
> =A0 =A0 removeChangeTZForm
> =A0 =A0 /gitweb-static/gitweb.js:785
> =A0 onTZFormChange
>=20
> =A0 line 785: var removed =3D container.removeChild(popup);
>=20
> =A0 It works in Mozilla 1.17.2, Konqueror 3.5.3, Firefox 3.6.15, 3.6.=
16
> =A0 and 4.0, Internet Explorer 8.0, Opera 10.63.

Something strange is happening here.  removeChangeTZForm looks like thi=
s:

  function removeChangeTZForm(documentFragment, target, tzClassName) {
	// find containing element, where we appended timezone selection UI
	// `target' is somewhere inside timezone menu
	var container =3D target.parentNode, popup =3D target;
	while (container &&
	       container.className !=3D=3D tzClassName) {
		popup =3D container;
		container =3D container.parentNode;
	}
	// safety check if we found correct container,
	// and if it isn't deleted already
	if (!container || !popup ||
	    container.className !=3D=3D tzClassName ||
	    popup.className     !=3D=3D 'popup') {
		return documentFragment;
	}

	// timezone selection UI was appended as last child
	// see also displayChangeTZForm function
	var removed =3D container.removeChild(popup); // <--- !!! here Chrome =
throws exception !!!
	if (documentFragment.firstChild !=3D=3D removed) { // the only child
		// re-append it so it would be available for next time
		documentFragment.appendChild(removed);
	}
	// all of inline style was added by this script
	container.removeAttribute('style');

	return documentFragment;
  }

Note that from above code one would assume that after first loop we
would assert that we always have  popup.parentNode =3D=3D=3D contained.
When working with JavaScript debugger in Google Chrome I have found
that at the time that exception is thrown popup.parentNode is
DocumentFragment, not HTMLElement / HTMLSpanElement.

Something strange is going there.  I'd check if not setting 'onblur'
event handler (which doesn't work as expected anyway) would help.

--=20
Jakub Narebski
Poland
