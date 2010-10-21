From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 06/21] notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
Date: Thu, 21 Oct 2010 15:16:22 +0200
Message-ID: <201010211516.23091.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <1287626936-32232-7-git-send-email-johan@herland.net> <20101021052100.GB2413@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 15:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8v1Z-0007dI-MH
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 15:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916Ab0JUNRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 09:17:36 -0400
Received: from smtp.opera.com ([213.236.208.81]:60069 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab0JUNRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 09:17:36 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9LDGNuY008512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 13:16:23 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20101021052100.GB2413@burratino>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159502>

On Thursday 21 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > --- a/notes.c
> > +++ b/notes.c
> > @@ -303,13 +298,17 @@ static void note_tree_insert(struct
> > notes_tree *t, struct int_node *tree, GET_PTR_TYPE(*p) ==
> > PTR_TYPE_SUBTREE);
> >  	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty
> > note */ free(entry);
> > -		return;
> > +		return 0;
> >  	}
> >  	new_node = (struct int_node *) xcalloc(sizeof(struct int_node),
> > 1); -	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
> > -			 combine_notes);
> > -	*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
> > -	note_tree_insert(t, new_node, n + 1, entry, type, combine_notes);
> > +	ret = note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
> > +			       combine_notes);
> > +	if (!ret) {
> > +		*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
> > +		ret = note_tree_insert(t, new_node, n + 1, entry, type,
> > +				       combine_notes);
> > +	}
> > +	return ret;
>
> Micronit: it would probably be clearer to write
>
> 	if (ret)
> 		return ret;
> 	*p = SET_PTR_TYPE(...
> 	return note_tree_insert(...
>
> to avoid a little nesting.

Agreed. Will be fixed in the next iteration.


Thanks,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
