From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v5 4/9] connect: make parse_connect_url() return
 separated host and port
Date: Tue, 17 May 2016 07:53:41 +0900
Message-ID: <20160516225341.GA19595@glandium.org>
References: <20160516000740.19042-1-mh@glandium.org>
 <20160516000740.19042-5-mh@glandium.org>
 <xmqqr3d1zkz7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2RP1-0004VO-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbcEPWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:54:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56082 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcEPWyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:54:13 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b2ROP-000584-Da; Tue, 17 May 2016 07:53:41 +0900
Content-Disposition: inline
In-Reply-To: <xmqqr3d1zkz7.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294813>

On Mon, May 16, 2016 at 03:39:08PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > +	get_host_and_port(&host, &port);
> > +
> > +	if (*host && !port) {
> > +		/* The host might contain a user:password string, ignore it
> > +		 * when searching for the port again */
> > +		char *end_user = strrchr(host, '@');
> > +		port = get_port(end_user ? end_user : host);
> 
> Scanning from the right because host part would never have '@', but
> there could be an invalid URL with an unquoted '@' in userinfo part?
> Then this makes sense.

Indeed, I forgot to update the comment after the discussion on this
list.

> > diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> > index 91a69fc..9acba2b 100755
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -553,7 +553,7 @@ check_prot_path () {
> >  	Diag: protocol=$2
> >  	Diag: path=$3
> >  	EOF
> > -	git fetch-pack --diag-url "$1" | grep -v hostandport= >actual &&
> > +	git fetch-pack --diag-url "$1" | grep -v host= | grep -v port= >actual &&
> 
> A single process:
> 
> 	... | grep -v -e '^host=' -e '^port='

heh, I'm actually replacing it with a single egrep in a subsequent
patch, following feedback from previous round, but missed that there was
this intermediate step with multiple greps still. Do you want an update
anyways, or does only the final result really matter? I guess I can
update it in any case, since I'll have to update the patch for the
comment above anyways.

Mike
