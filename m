From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11] gitweb: Change timezone
Date: Tue, 12 Apr 2011 14:44:19 +0200
Message-ID: <201104121444.20633.jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com> <BANLkTik9D6++P1rg+VbvKj9oTFhRYNmrpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 15:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9dbf-0004Te-4Q
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 15:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab1DLN0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 09:26:04 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46227 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab1DLN0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 09:26:01 -0400
Received: by bwz15 with SMTP id 15so5357326bwz.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=y7GgfE3pl3bTHbqodO18A23YIEtbQiRCvyAR6wxSMnc=;
        b=iUd3Tf0e3uG9FQ35sDWft5HOPXTmcv5dWyI1qpWZBj3tXlN4L3nGNR+YdaGnzaovUb
         QTanJcWuMVEJuTtAdZzVFKS7Cv41sEJlGdVgg+VbTrRe3wK4Bzss9Fcz9fgp8IinMHXP
         Sh9cdZEKh8ehJVcXlo6h1N0sMN5ya7PX6FOFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UgKtCceQXwgcyBoDpo/FKEjwTJbNhytWpqIoeWyCq5Q/2oBddXpYsDLSE54drtMGKm
         IN16Sic6SXsHgb1zMppzJlK+t2kYAZVjnupG77E78pyQYMq8PrKQdjMb5R3AlkpHRhJm
         vEComwvqaNIGWWDjMQRa0plMRivY8SH5hTFeI=
Received: by 10.204.84.142 with SMTP id j14mr4030060bkl.20.1302614760281;
        Tue, 12 Apr 2011 06:26:00 -0700 (PDT)
Received: from [192.168.1.13] (abvr44.neoplus.adsl.tpnet.pl [83.8.215.44])
        by mx.google.com with ESMTPS id v21sm3859967bkt.23.2011.04.12.06.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2011 06:25:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTik9D6++P1rg+VbvKj9oTFhRYNmrpQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171389>

On Tue, 12 Apr 2011, Kevin Cernekee wrote:
> On Sat, Apr 9, 2011 at 3:49 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> >
> > This is split version (with assorted cleanups) of J.H. patch adding
> > JavaScript-base ability to change timezone in which dates are
> > displayed.
>=20
> Jakub,
>=20
> Thanks for the update.  This UI does seem to work better than the
> original "[+]" dropdown interface.

Thanks.

Notice that you can have only one timezone selection menu opened.  You
have to close existing to be able to open it in different place (near
different date), even though onclick handler still triggers.

This is caused by the fact that appending DocumentFragment to an elemen=
t
"empties" it, as described in DOM 2 Core specification[1]:

  appendChild
    Adds the node newChild to the end of the list of children of this
    node. If the newChild is already in the tree, it is first removed.

    Parameters

       newChild of type Node
          The node to add.

          If it is a DocumentFragment object, the entire contents of th=
e
          document fragment are moved into the child list of this node.
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^

[1]: http://www.w3.org/TR/2000/REC-DOM-Level-2-Core-20001113/core.html#=
ID-184E7107

That is also the case that we need to read it when closing timezone
selection menu in removeChangeTZForm():

	// timezone selection UI was appended as last child
	// see also displayChangeTZForm function
	var removed =3D container.removeChild(popup);
	if (documentFragment.firstChild !=3D=3D removed) { // the only child
		// re-append it so it would be available for next time
		documentFragment.appendChild(removed);
	}

Though it wasn't what I thought it is needed for when writing i ;-)


You wrote in your response to original J.H. patch

  "Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on t=
imezone"
  http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=3D=
169891

KC> I'm wondering if there might be a better place on the page to put t=
he
KC> TZ selection. =C2=A0It isn't immediately obvious to the user what t=
he
KC> extra " + " does, and it seems to cause some issues.

Well, I am not sure if it is immediately obvious to user that he/she
can click on date to change its timezone.

Underlining on hover (like for links... though I guess that we really
should make style similar to links but not the same: it is not true lin=
k),
changing cursor and title attribute hopefully help here.

Ideas on having it better discoverable certainly welcome.

KC> If you decide to keep it where it is, you might want to consider
KC> absolute or fixed positioning so that other elements do not wrap
KC> around it. =C2=A0IOW it would work more like the dropdown menus on =
many
KC> sites.

In this version it is done using absolute positioning, though there
are few quirks and things to know about:

 * To be able to position timezone menu relative to some element using
   absolute positioning you need to make said element relatively=20
   positioned.

   	target.style.position =3D 'relative';

   We might have used CSS instead...

 * Floating inside block element works if it has some specified size.
   Normal, relative and fixed positioned elements have size given by
   its parent element.  For absolutely positioned block element you hav=
e
   to specify width explicitly, and not have it fit to width.

   That is why close-button uses absolute positioning rather than being
   a float.

 * The only absolute position relative to parent inline-block relative
   positioned element is top left.  All others doesn't work correctly
   e.g. in my ancient Mozilla 1.17.2 -- in 'log' view timezone menu got
   created on the right and outside viewport (page).

   That is why current solution is to use "top: 0; left: 0;".


KC> The timezone fixup javascript seemed to work reasonably well, excep=
t
KC> for the hiccup with IE6. =C2=A0Maybe it would be worth splitting th=
is into
KC> two patches: one to rewrite the timestamps, and a second one to add
KC> the TZ selection interface.

Well, I have split in more than 2 patches, but rewriting timezone of
timestamps is separate from TZ selection interface.

=20
> The new code appears to degrade gracefully on IE6 (everything shown i=
n UTC).

I don't know about IE6, but there was bug in IE-specific code in=20
addCssRule (was 'stylesheets' when variable is named 'stylesheet').
Thanks for noticing this; fixed in new iteration.

Now at least in IE8 (Internet Explorer 8.0.6001.18702) it works as=20
expected.
=20
> Tests on Firefox 3.6.15 looked OK.

Tests in the following browsers looked OK:
 * Firefox 1.7.12 (Gecko/20050123)
 * Epiphany 1.6.5 (Gecko/20050123)
 * Firefox 4.0   - note: not as extensively tested
 * Firefox 3.6.16 (Gecko/20110319)
 * Internet Explorer 8.0 (8.0.6001.18702)


Tests in Konqueror 3.5.3 (KHTML) shown something strange: it has no
problems with named function expressions here

	document.onclick =3D function onclickHandler(event) {

but was showing syntax error in similar

	return function closeTZForm(event) {

that I used in new version of 10/11 patch.  As we don't redeploy handle=
r,
we don't need function name, so in current version we use

	return function (event) {


Also after displaying timezone selection menu, and either selecting
timezone or canceling selection, so that timezone UI vanishes, the
date that was clicked ends up displaced a bit - moved slightly up.
This doesn't affect layout too badly, and is probably bug in this versi=
on
of Konqueror.

Tests in the following browsers gracefully degrade to UTC:
 * Lynx 2.8.5rel.1
 * ELinks 0.10.3
 * w3m 0.5.1+cvs-1.946

>=20
> Chromium 6.0.472.62 (59676) does not like this operation:
>=20
> Uncaught Error: NOT_FOUND_ERR: DOM Exception 8
>   removeChangeTZForm
>   /gitweb-static/gitweb.js:785
> onTZFormChange
>=20
> line 785: var removed =3D container.removeChild(container.lastChild);

Strange.  I confirm the same behavior in Google Chrome 10.0.648.204,
even after changes that I though should eliminate this exception.

Note that this bug/exception doesn't cause timezones to be not
translated, it only makes timezone selection menu not working.
=20
removeChild() is DOM 2 Core method, `container.lastChild' exists and
is child of `container' element.  IE8, Firefox 3.6 and 4.0, Opera 10.63
all work, it's only Chrome / Chromium that has problems...

> Opera 10.63 resets target.selectedIndex to 1 after calling
> removeChangeTZForm() from onTZFormChange().  Net effect is that you'r=
e
> always stuck in the "local" zone.  Here is a workaround that fixed it
> for me:
>=20
>        var target =3D event.target || event.srcElement;
>        var selectedIndex =3D target.selectedIndex;
>=20
>        removeChangeTZForm(documentFragment, target, tzClassName);
>=20
>        var selected =3D target.options.item(selectedIndex);

Or just change order of those statements:

	 event =3D event || window.event;
	 var target =3D event.target || event.srcElement;

	 var selected =3D target.options.item(target.selectedIndex);
	 removeChangeTZForm(tzSelectFragment, target, tzClassName);

Could you check that this version works correctly in Opera 10?
Thanks in advance.

>=20
> Couple other random nitpicks:
>=20
> > +	// server-side of gitweb produces datetime in UTC,
> > +	// so if tz is 'utc' there is no need for changes
> > +	var nochange =3D tz =3D=3D=3D 'utc';
>=20
> If I delete my gitweb_tz cookie, then refresh the page:
>=20
>  - All times show up in my browser's local time (good)
>=20
>  - Clicking UTC/GMT on the dropdown has no immediate effect; I need t=
o
>    refresh the page again to see the times change (bad)

I'm sorry, it looks like I tried to be too clever.

We should either do this _only_ in onloadTZSetup and not in fixDatetime=
TZ,
or abandon this micro-optimization entirely - we have to enumerate all
elements with "datetime" class to add 'title' attribute anyway.

The first solution was chosen in next version of this patch.
=20
> > +	my (undef, undef, $datetime_class) =3D
> > +		gitweb_get_feature('javascript-timezone');
> > +	if ($datetime_class) {
> > +		$strtime =3D qq!<span class=3D"datetime">$strtime</span>!;
>=20
> Should this hard-code class "datetime", or use $datetime_class from
> the gitweb server configuration?

Sorry, my mistake.  Fixed.

> > +/* JavaScript-base timezone manipulation */
>=20
> Might want to reword as "JavaScript-based"

Done.
=20
> > +		// refresh cookie, so it expires 7 days from last use of gitweb
> > +		setCookie(tzCookieName, tzCookie, { expires: 7, path: '/' });
>=20
> Hmm, only 7 days?

Well, in new version where expire time is set in one place (was one to
set cookie after timezone selection, one to refresh cookie), and is=20
increased to 14 days (2 week).  Please also remember that it is time
from last visit to gitweb, not last timezone change.

> > + * and instals appropriate onclick trigger (via event delegation).
>=20
> "installs"

Done.


Thanks again for reviewing it.

--=20
Jakub Narebski
Poland
