From: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] push: deny policy to prevent pushes to unwanted
 remotes.
Date: Mon, 30 May 2016 17:30:38 +0200 (CEST)
Message-ID: <1696484918.188215.1464622238984.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr> <vpq37ozd6o7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	larsxschneider@gmail.com, rsbecker@nexbridge.com, aaron@schrab.com,
	gitster@pobox.com, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 17:22:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7P1W-0006Ki-J5
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 17:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbcE3PWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 11:22:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:47953 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932508AbcE3PW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 11:22:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4B75920A5;
	Mon, 30 May 2016 17:22:26 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csuR4IfpxeAJ; Mon, 30 May 2016 17:22:26 +0200 (CEST)
Received: from zm-int-mbx7.grenet.fr (zm-int-mbx7.grenet.fr [130.190.242.146])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2F0992054;
	Mon, 30 May 2016 17:22:26 +0200 (CEST)
In-Reply-To: <vpq37ozd6o7.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Win)/8.0.9_GA_6191)
Thread-Topic: push: deny policy to prevent pushes to unwanted remotes.
Thread-Index: dXlx0CidBdM96uPpRM5K9CUooG5mLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295906>



----- Mail original -----
> Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:
> 
> > Currently, a user wanting to prevent accidental pushes to the wrong remote
> > has to create a pre-push hook.
> > The feature offers a configuration to allow users to prevent accidental
> > pushes
> > to the wrong remote. The user may define a list of whitelisted remotes, a
> > list
> > of blacklisted remotes and a default policy ("allow" or "deny"). A push
> > is denied if the remote is explicitely blacklisted or if it isn't
> > whitelisted and the default policy is "deny".
> 
> Not really serious, but the text above is weirdly wrapped, probably by
> hand. I'm sure your text editor can do better and quicker ;-).

Yes indeed it was hand wrapped, it will be changed in the next version,
thanks for the hint!

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index 53f00db..1478ce3 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2517,6 +2517,23 @@ remote.pushDefault::
> >  	`branch.<name>.remote` for all branches, and is overridden by
> >  	`branch.<name>.pushRemote` for specific branches.
> >  
> > +remote.pushBlacklisted::
> > +	The list of remotes the user is forbidden to push to.
> > +	See linkgit:git-push[1]
> 
> I'd have spelled that "pushBlacklist" (no 'ed'). I think variable names
> usually do not use verbs. But I'm fine with your version too.

Ok it makes sense, we will change for "pushBlacklist".

> > +For example, if we set up the configuration variables like this:
> > +	git config --add remote.pushBlacklisted repository.com
> > +	git config --add remote.pushWhitelisted repository.com/Special_Folder
> > +Any push of this form will be accepted:
> > +	git push repository.com/Special_Folder/foo
> > +While those ones for example will be denied:
> > +	git push repository.com/Normal_Folder/bar
> 
> Please, look at the rendered output of your documentation, and notice
> it's broken. We'd typically use the asciidoc syntax for inline code here
> (between -----).

Indeed the rendered doc is broken, it will be fixed in the next version.

> > +An error will be raised if the url is blacklisted and whitelisted at the
> > same.
> 
> "at the same time"?
> 
> But as-is, this sentence conflicts with the previous "the more the url
> in the config prefixes the asked url the more priority it has."
> statement.

I understand the confusion, it's not very clear. What we wanted to say
was that:
    pushBlacklist = example.com/
    pushWhitelist = example.com/
would raise an error, because the "priority rule" can't be applied.
We will change the sentence.

> The documentation doesn't talk about the URL-normalization the code is
> doing. I think a reasonable behavior would be:
> 
> pushBlacklisted = example.com/ => deny all accesses to example.com
> pushBlacklisted = http://example.com/ => deny HTTP accesses to
>                                          example.com
> 
> The second is a valid use-case IMHO, some people may want to forbid some
> protocols. Actually, one may even want to whilelist only one protocol
> and write stg like this to force HTTPS on host example.com:
> 
>   pushBlacklisted = example.com
>   pushWhitelisted = https://example.com

As of right now the protocol is not handled, we just ignore it.
We already thought about handling it the way you described but
we found out some problems:
    pushBlacklist = example.com
    pushWhitelist = https://example.com
        -> push example.com forbidden EXCEPT with https

    pushBlacklist = example.com/example2
    pushWhitelist = https://example.com
        -> push https://example.com/example2
            -> Allow or deny?

To sum up the problem, what should be the priority between a
protocol-matching rule and a sub-folder-matching rule?
Perhaps adding a configuration variable?
    pushPriority = "protocol"/"sub-folder" (needs renaming)

> BTW, these use-cases could motivate some per-blacklist deny message
> like
> 
> [remote "example.com"]
> 	pushDenyMessage = "Please use HTTPS when you push to example.com"
> 
> I don't think it has to be implemented now though (better have users get
> used to the basic feature and see if more is needed later).

Interesting idea, perhaps a simplified version could be:
    pushDenyProtocolMessage = "This protocol is not allowed for this remote"
    pushDenyRemoteMessage = "This remote is not authorized"
    (as above v ery roughnaming)

> > +static const char *string_url_normalize(const char *repo_name)
> > +{
> > +	if (starts_with(repo_name, "file://"))
> > +		return repo_name + 7;
> 
> There are many instances of this in Git's codebase, but we now try to
> avoid magic numbers like this, and would use strlen("file://") instead.
> Actually, we even have skip_prefix() precisely for this use-case.

Ok we will change it and use the skip_prefix() function.

> > +	if (is_url(repo_name)) {
> > +		struct url_info url_infos;
> > +		url_normalize(repo_name, &url_infos);
> > +		return url_infos.url + url_infos.host_off;
> 
> I think this would deserve a comment to explain why and what this is
> doing, like /* turn ... into ... to ... */.

This code removes all "unnecessary" parts of the url (protocol, user...).
Seeing the comments above, this code will probably be changed but we will
comment tricky code more often.

> > +test_expect_success 'unsetup' '
> 
> "cleanup" ?

Ok that's better

> (I just did a very quick look at the code, I think we need an agreement
> on the details of specification before a more detailed review)

I agree

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> 
