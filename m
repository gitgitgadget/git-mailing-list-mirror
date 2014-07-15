From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v8 2/2] test-config: add tests for the =?utf-8?b?Y29uZmlnX3NldA==?= API
Date: Tue, 15 Jul 2014 11:10:26 +0000 (UTC)
Message-ID: <loom.20140715T125714-160@post.gmane.org>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com> <1405049655-4265-3-git-send-email-tanayabh@gmail.com> <xmqq8unz4v4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 13:10:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X70dE-0007Xl-2G
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 13:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbaGOLKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 07:10:43 -0400
Received: from plane.gmane.org ([80.91.229.3]:59693 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758107AbaGOLKi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 07:10:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1X70d2-0007Td-Ti
	for git@vger.kernel.org; Tue, 15 Jul 2014 13:10:36 +0200
Received: from 223.226.20.20 ([223.226.20.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 13:10:36 +0200
Received: from tanayabh by 223.226.20.20 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 13:10:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 223.226.20.20 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253553>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Tanay Abhra <tanayabh <at> gmail.com> writes:
> 
> > diff --git a/test-config.c b/test-config.c
> > new file mode 100644
> > index 0000000..dc313c2
> > --- /dev/null
> > +++ b/test-config.c
> >  <at>  <at>  -0,0 +1,125  <at>  <at> 
> > +
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int i, val;
> > +	const char *v;
> > +	const struct string_list *strptr;
> > +	struct config_set cs;
> > +	git_configset_init(&cs);
> > +
> > +	if (argc < 2) {
> > +		fprintf(stderr, "Please, provide a command name on the command-line\n");
> > +		return 1;
> > +	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
> > +		if (!git_config_get_value(argv[2], &v)) {
> > +			if (!v)
> > +				printf("(NULL)\n");
> 
> This one is dubious.  Is this for things like
> 
> 	(in .git/config)
> 	[receive]
>         	fsckobjects
>

Yes, it was meant for the above case.

> and asking with
> 
> 	$ git config receive.fsckobjects
> 
> which I think gives an empty string?  We may want to be consistent.

$ git config -l
shows NULL values as foo.bar
empty values as      foo.bar=
So there is a difference between the two.
$ git config receive.fsckobjects does covert the NULL value to a ""(empty
string).

I had to diffrentiate between the two, so I took the path printf takes for
NULL strings, it prints them as "(NULL)".
