From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: RFC GSoC idea: new "git config" features
Date: Fri, 28 Feb 2014 13:51:28 +0100
Message-ID: <53108650.2020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:51:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMuf-0004gn-N4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaB1Mvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:51:33 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58826 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751677AbaB1Mvc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 07:51:32 -0500
X-AuditID: 1207440e-f79c76d000003e2c-e1-531086539b59
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 90.15.15916.35680135; Fri, 28 Feb 2014 07:51:31 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SCpTWI029317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 07:51:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqBvcJhBsMOspp0XXlW4mB0aPz5vk
	AhijuG2SEkvKgjPT8/TtErgzzh7/ylxwUb7i0c3FjA2MdyW6GDk5JARMJNZ8P8cGYYtJXLi3
	Hsjm4hASuMwocfvAEyYI5wWTxKU3p9lBqngFtCVWbD7CCGKzCKhKLH56mwXEZhPQlVjU08wE
	YosKBEusvvyABaJeUOLkzCdgtghQza5nV8G2CQsYSqy9e5q5i5EDaLO4RE9jEEiYWUBH4l3f
	A2YIW15i+9s5zBMY+WYhmTQLSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+Vm
	luilppRuYoQEGd8Oxvb1MocYBTgYlXh4J3jyBwuxJpYVV+YeYpTkYFIS5VVuFQgW4kvKT6nM
	SCzOiC8qzUktPsQowcGsJML7pAkox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoE
	k5Xh4FCS4DUHGSpYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPirz4YmDsgaR4gPaC
	tfMWFyTmAkUhWk8x6nLcbvv1iVGIJS8/L1VKnLeyBahIAKQoozQPbgUspbxiFAf6WJjXA2QU
	DzAdwU16BbSECWgJpyfYkpJEhJRUA6O088PA7mDH3QfNN3yMemBftfie9u6zCx4p79F9/VxT
	UGExu4HYSb+7T/dfcuWf8im9Qz1P6zxz3+2tb9ZdSc5Ua2l77pU87Wzhrnct9rYVx2UVjRIt
	T+bti/2684Hlwgr1hrq7TWuKn8g+e28XOud1T+qmd7fT3/hnzlLX+VS0yXiL7QmN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242952>

I just wrote up another double-idea that has been stewing in my head for
a while:

* Allow configuration values to be unset via a config file
* Fix "git config --unset" to clean up detritus from sections that are
left empty.

These ideas are more "out there" than the last, and might be too
controversial to be implemented, let alone as a GSoC project.  I'd
definitely like some feedback.

And if you like this idea or the other one I proposed, please volunteer
to be a co-mentor!  I will be traveling for a few weeks this summer, so
I *won't* be able to be the sole mentor to a student.

I wrote up this idea in the following pull request:

    https://github.com/git/git.github.io/pull/6

I will also append the text, for your mailing-list-reading convenience.

Michael

### `git config` improvements

This project proposes the following two improvements to `git config`.
Please note that this project has a significant "political" component
to it, because some of the details of the features will be
controversial.

#### Unsetting configuration options

Some Git configuration options have an effect by their mere existence.
(I.e., setting the option to "false" or the empty string is different
than leaving it unset altogether.)  Also, some configuration options
can take multiple values.

However, there is no way for an option file to "unset" an option--that
is, to change the option back to "unset".  This is awkward, because
configuration values are read from various places (`/etc/gitconfig`,
`~/.config/git/config` or `~/.gitconfig`, and `$GIT_DIR/config`, plus
perhaps files that are included by other configuration files).
Therefore, if an option is set in one of the earlier files, there is
no way for it to be unset in a later one.  The unwanted option might
have even been set in a file like `/etc/gitconfig` that the user
doesn't have permission to modify.

It would be nice to have a syntax that can be used to unset any
previously-defined values for an option.  Perhaps

    [section "subsection"]
            !option

The above is currently currently a syntax error that causes Git to
terminate, so some thought has to go into a transition plan for
enabling this feature.  Maybe a syntax has to be invented that
conforms to the current format, like

    [unset]
            name = section.subsection.option

Because options are currently processed as they are read, this change
will require the code that reads options files to be changed
significantly.

Leave yourself a lot of time to attain a consensus on the mailing list
about how this can be done while retaining reasonable backwards
compatibility.

#### Tidy configuration files

When a configuration file is repeatedly modified, often garbage is
left behind.  For example, after

    git config my.option true
    git config --unset my.option
    git config my.option true
    git config --unset my.option

the bottom of the configuration file is left with the useless lines

    [my]
    [my]

It would be nice to clean up such garbage when rewriting the
configuration file.  This project is a bit tricky because of the
possible presence of comments.  For example, what if an empty section
looks like this:

    [my]
            # This section is for my own private settings

or this:

    [my]
    # This section is for my own private settings

or this:

    # This section is for my own private settings:
    [my]

?  In some such cases it might be desireable either to retain the
section even though it is empty, or to delete the comment along with
the section.  Very likely there will be some obvious patterns when
everybody agrees that an empty section can be deleted, and other, more
controversial cases where you will have to reach a consensus on the
mailing list about what should be done.

 - Language: C
 - Difficulty: medium
 - Possible mentors: Michael Haggerty


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
