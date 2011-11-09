From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v3] post-receive-email: explicitly set Content-Type
 header
Date: Wed, 9 Nov 2011 19:01:48 +0400
Message-ID: <20111109190148.62a81b94@ashu.dyn.rarus.ru>
References: <20111007201932.GC29712@elie.hsd1.il.comcast.net>
	<1320836458-24088-1-git-send-email-Alex.Crezoff@gmail.com>
	<7vy5vpv11n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 16:02:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO9fA-0005xi-5w
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 16:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403Ab1KIPB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 10:01:56 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47628 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab1KIPBz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 10:01:55 -0500
Received: by bke11 with SMTP id 11so1413052bke.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=tUCCI9m2NUrR6cvVZeWF3V4zFEylpDgU3AqIjI3/K1c=;
        b=KyPnsTEARg1HBbBxAhAwJq+8vlmhbGeiEJdkPZZVt6FUvA9CcVjMcZMHuhp0fU9QfF
         LuUqehHOpurOs8pEdWsBd3pZE810aTdOeO7sQWepWMrZRrXqdHXH0lmmMmwBEXysMRMx
         KGzEer30Gfw+hitBTBgrKObpXVuYfP36NRKxs=
Received: by 10.204.141.8 with SMTP id k8mr2107431bku.14.1320850913728;
        Wed, 09 Nov 2011 07:01:53 -0800 (PST)
Received: from ashu.dyn.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id m4sm24219415fad.1.2011.11.09.07.01.52
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 07:01:53 -0800 (PST)
In-Reply-To: <7vy5vpv11n.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185160>

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
> 
> > Some email clients (e.g. claws-mail) incorrectly display
> > message body when there is no Content-Type header and charset
> > explicitly defined.
> > So, set explicitly Content-Type header. Its charset
> > can be defined with hooks.emailcharset config variable.
> >
> > NB: This above-mentioned charset may differ from
> > i18n.logOutputEncoding, because e.g. gitweb expects (for now)
> > i18n.logOutputEncoding set to UTF-8 to display logs correctly.
> >
> > Also, introduce hooks.gitopts config variable
> > with the default '-c core.quotepath=false'.
> > This takes into account that we want to see pretty email-message
> > with well-looking messages and list of changed filenames.
> > And usually non-ASCII filenames are in the same
> > encoding that commit messages are.
> 
> (style) Why such an extremely ragged looking line-wrap of paragraphs?
I'm not good enough in English spelling ;(
> 
> > Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> > ---
> 
> In this space, please describe what happened during v1 and v2, and
> how is this round different to help reviewers. Pointers to list
> archive, e.g.
> http://thread.gmane.org/gmane.comp.version-control.git/181737, would
> be helpful.
> 
> People involved in v1/v2 discussion are missing from the Cc: line.
> Please do not give a false impression that you are hiding from them.
Oh, I've missed that moment, sorry all
> 
> > diff --git a/contrib/hooks/post-receive-email
> > b/contrib/hooks/post-receive-email index ba077c1..913be89 100755
> > --- a/contrib/hooks/post-receive-email
> > +++ b/contrib/hooks/post-receive-email
> > @@ -65,6 +65,14 @@
> >  #   Default is "--stat --summary --find-copies-harder". Add -p to
> > those #   options to include a unified diff of changes in addition
> > to the usual #   summary output.
> > +# hooks.gitopts
> > +#   git options for the git diff-tree invocation that shows
> > changes. +#   Default is '-c core.quotepath=false' to be able to
> > see non-ASCII filenames +#   used in a project.
> 
> We do not particularly appreciate a patch that does two unrelated
> things ("they are both related to post-receive-email" is not an
> argument). Wouldn't this be useful even if the change to add
> hooks.emailcharset turned out to be unwanted, or vice versa?
The main reason was that using core.quotepath=false leads to showing
file names "correctly" according to commit messages encoding to make
email-message look pretty.
> 
> > +# hooks.emailcharset
> > +#   The charset used in Content-Type header. UTF-8, if not
> > specified. +#   It can differ from i18n.logOutputEncoding (not to
> > mess-up with gitweb +#   which expects i18n.logOutputEncoding to be
> > set to UTF-8)
> 
> Why "UTF-8" instead of "i18n.logoutputencoding" if not specified?
Well, you're right.
For the explanation:
AFAIU, such hooks are used on central servers to notify involved people
about changes. And AFAIU the same server repos are used with gitweb
(which AFAIK requires i18n.logOutputEncoding=UTF-8)

But in common case "i18n.logoutputencoding" is more suitable.

> 
> > @@ -234,6 +242,9 @@ generate_email_header()
> >  	cat <<-EOF
> >  	To: $recipients
> >  	Subject: ${emailprefix}$projectdesc $refname_type
> > $short_refname ${change_type}d. $describe
> > +	MIME-Version: 1.0
> > +	Content-Type: text/plain; charset=$emailcharset
> > +	Content-Transfer-Encoding: 8bit
> >  	X-Git-Refname: $refname
> >  	X-Git-Reftype: $refname_type
> >  	X-Git-Oldrev: $oldrev
> > ...
> > @@ -730,6 +734,19 @@ custom_showrev=$(git config hooks.showrev)
> >  maxlines=$(git config hooks.emailmaxlines)
> >  diffopts=$(git config hooks.diffopts)
> >  : ${diffopts:="--stat --summary --find-copies-harder"}
> > +gitopts=$(git config hooks.gitopts || echo '-c
> > core.quotepath=false') +emailcharset=$(git config
> > hooks.emailcharset || echo 'UTF-8') +
> > +projectdesc=$(sed -ne '1p' "$GIT_DIR/description" 2>/dev/null)
> > +# Check if the description is unchanged from it's default, and
> > shorten it to +# a more manageable length if it is
> > +if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> > +then
> > +	projectdesc="UNNAMED PROJECT"
> > +fi
> > +# Leave description in UTF-8 to be used in the Subject header
> > +# But convert it to an hooks.emailcharset encoding to be used in a
> > message body +projectdesc_e=$(echo $projectdesc | iconv -f UTF-8 -t
> > $emailcharset 2>/dev/null)
> 
> Hmm, this generates a piece of e-mail whose subject line is in UTF-8
> (without B/Q quoting) and message body is in totally different
> encoding. Is it what mailers really want to see?
Here you're right, too. Windows email clients may interpret Subject
header without B/Q quoting in its default Windows charset, and as far as
it may contain non-English project description, so Subject would look
ugly. But I'll try to test with some clients.
> 
> It almost seems backwards; converting the payload to UTF-8 and always
> sending UTF-8 would be a simpler approach, methinks.
Sounds reasonable
