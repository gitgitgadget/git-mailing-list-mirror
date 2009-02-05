From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 01/11] Add support code to handle plugin property
	changes
Date: Thu, 5 Feb 2009 08:40:22 -0800
Message-ID: <20090205164022.GK26880@spearce.org>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-2-git-send-email-torarnv@gmail.com> <20090205155337.GH26880@spearce.org> <498B1563.4070905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7IU-0007zE-RD
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZBEQkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbZBEQkX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:40:23 -0500
Received: from george.spearce.org ([209.20.77.23]:37969 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbZBEQkX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:40:23 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4A56638210; Thu,  5 Feb 2009 16:40:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498B1563.4070905@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108580>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> Shawn O. Pearce wrote:
> > Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> >> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator=
=2Ejava b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> >> index fced643..d4a9e8e 100644
> >> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> >> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
> >> @@ -44,9 +48,24 @@
> >>   * This is a plugin singleton mostly controlling logging.
> >>   */
> >>  public class Activator extends AbstractUIPlugin {
> >> +
> >> +	/**
> >> +	 *  The one and only instance
> >> +	 */
> >>  	private static Activator plugin;
> >=20
> > What does this field do?  I don't see it referenced anywhere...
>=20
> It's the singleton instance, referenced from Activator.getDefault(). =
I
> just documented it :)

*sigh*.  I haven't had enough caffiene yet this morning.  Yes,
I see what you mean, its only the Javadoc that was added.  OK,
forget I said anything here.  :-)
=20
> >>  	/**
> >> +	 * Property listeners for plugin specific events
> >> +	 */
> >> +	private static List<IPropertyChangeListener> propertyChangeListe=
ners =3D
> >> +		new ArrayList<IPropertyChangeListener>(5);
> >=20
> > None of these list accesses are thread-safe.  Are we certain they
> > call will come from a single thread, e.g. the SWT event thread?
> > Or do we need to put synchronized protection in here?
>=20
> The addPropertyChangeListener method is called at startup from the
> GitLightweightDecorator constructor, in one of the worker threads, an=
d
> same thing with removePropertyChangeListener from dispose(). The
> broadcastPropertyChange method is called in the main thread every tim=
e
> the Git decorator preference page is closes.
>=20
> This is the sync model used by other Eclipse plugins for keeping trac=
k
> of propertyChangeListeners, for example in the TeamUIPlugin, that's w=
hy
> I assumed it was OK. I'm perfectly fine with syncrhronizing it though=
,
> similar to repositoryChangeListeners in GitProjectData?

OK, I see.  I'd perhaps prefer to make this thread-safe just in case.
If its always coming off the SWT event thread, then just tossing
a synchronized keyword on all 3 methods should be Good Enough(tm).

--=20
Shawn.
